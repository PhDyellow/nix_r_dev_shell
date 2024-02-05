{
  description = "Nix shell for working with R projects";

  inputs = {

    nixpkgs-unstable = {
      # url = "github:NixOS/nixpkgs/nixos-unstable";
      # url = "github:NixOS/nixpkgs/master";
      # url = "github:PhDyellow/nixpkgs?rev=1b886e9f282c1d912ab233883f345c2d65c15964";
      # url = "github:PhDyellow/nixpkgs/r-updates";
      # url = "github:NixOS/nixpkgs/r-updates";
      url = "github:PhDyellow/nixpkgs/r-torch-master-12";
    };

  };


  outputs = {self, nixpkgs-unstable, ...}@inputs:
    let
      pkgs = import nixpkgs-unstable {
        system = "x86_64-linux";
        config = {
          allowUnfree= true;
          # permittedInsecurePackages = [
          # "python-2.7.18.6-env"
          # "python-2.7.18.6"
          # ];
          hardware.opengl = {
            enable = true;
            setLdLibraryPath = true;
          };
          cudaSupport = true;
          nix.settings = {
            substituters = ["https://cuda-maintainers.cachix.org"];
            trusted-public-keys = ["cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="];
          };
        };
        overlays = [
          self.overlays.buildRPackage
          self.overlays.disable_debugpychecks
          ## Only enable one of these. Nix will choose the last uncommented version
          ## Caching works if all are commented out
          # self.overlays.blas-lapack-mkl
           # self.overlays.blas-lapack-amd ## R doesn't pass tests
          # self.overlays.blas-lapack-open
          (import ./packages/rpackages_overlay_flake.nix)
          # (import ./packages/gurobi_overlay.nix)
          (import ./packages/phantomjs2_overlay.nix) # Dropped from NixPkgs for being unmaintained and insecure. Needed by wdpar though
        ];
      };
      allpackages = (import ./all_packages.nix {pkgs = pkgs;
                                                python-install = python-tensorflow;});
      python-tensorflow = pkgs.python311.withPackages(ps: with ps; [
        # tensorflow
        numpy
        # keras
      ]);
      #   env = {
      #     RETICULATE_PYTHON = "${python-tensorflow}";
      #   };
    in
      {
        overlays = {
          buildRPackage = final: prev: {
            buildRPackage = prev.callPackage (nixpkgs-unstable + "/pkgs/development/r-modules/generic-builder.nix") {
              inherit (final.pkgs) R;
              inherit (final.pkgs.darwin.apple_sdk.frameworks) Cocoa Foundation;
              inherit (final.pkgs) gettext gfortran;
            };
          };

          # Best for open source
          blas-lapack-open = final: prev: {
            blas = prev.blas.override {
              blasProvider = final.openblas;
            };
            lapack = prev.lapack.override {
              lapackProvider = final.openblas;
            };
          };
          # Best for AMD cpus
          # Produces errors in R prcomp and does not
          # install
          # with or without threading support
          # blas64=true does not help
          blas-lapack-amd = final: prev: {
            blas = prev.blas.override {
              # blasProvider = final.amd-blis;
              blasProvider = prev.amd-blis.override{
                # blas64=true;
                # withOpenMP=false;
              };
            };
            lapack = prev.lapack.override {
              # lapackProvider = final.amd-libflame;
              lapackProvider = prev.amd-libflame.override{
                # blas64 = true;
                # withOpenMP=false;
              };
            };
          };
          # Best for intel cpus
          blas-lapack-mkl = final: prev: {
            blas = prev.blas.override {
              blasProvider = final.mkl;
            };
            lapack = prev.lapack.override {
              lapackProvider = final.mkl;
            };
          };

          disable_debugpychecks = final: prev: {
            python311 = prev.python311.override {
              packageOverrides = pyfinal: pyprev: {
                debugpy = pyprev.debugpy.overridePythonAttrs (_: {
                  doCheck = false;
                });
              };
            };
          };

        };


        containers."x86_64-Linux" = {
          ## Build with:
          ## nix build .#containers.x86_64-Linux.aus_bio_apptainer_r -o /tmp/r-apptainer-aus-bio.sif
          aus_bio_apptainer_r =
            pkgs.singularity-tools.buildImage {
              # singularity = pkgs.apptainer;
              name = "aus_bio_apptainer_r";
              contents = [
                # pkgs.slurm ## Doesn't help, slurm needs access to configs and databases
              ] ++ allpackages;
              # ++ [
              #   python-tensorflow
              # ];
              diskSize = 294192;
              memSize = 16096;
              runAsRoot = ''
                ## These should be done by singularity-tools, but aren't
                mkdir -p /etc
                touch /etc/passwd
                echo "root:x:0:0:System administrator:/root:/bin/sh" > /etc/passwd
                touch /etc/group
                echo "root:x:0:" > /etc/group

                mkdir -p /.singularity.d/env
                #echo "#!/usr/env/bin sh" >> /.singularity.d/env/90-environment.sh
                echo "export LC_ALL=C" >> /.singularity.d/env/90-environment.sh
                # echo "export RETICULATE_PYTHON=${python-tensorflow}/bin/python3.11" >> /.singularity.d/env/90-environment.sh
                # echo "export PYTHONPATH=${python-tensorflow}/lib/python3.11:${python-tensorflow}/lib/python3.11/site-packages" >> /.singularity.d/env/90-environment.sh

                echo "export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" >> /.singularity.d/env/90-environment.sh
                # chmod ugo+x /.singularity.d/env/90-environment.sh
                # touch /.singularity.d/env/94-appsbase.sh
                # echo "#!/usr/env/bin sh" >> /.singularity.d/env/94-appsbase.sh

                # chmod ugo+x /.singularity.d/env/94-appsbase.sh

                # mkdir -p /opt
                # mkdir -p /etc/localtime #this is actually a symlink to another directory. don't hardcode it
                # mkdir -p /etc/hosts #already done by apptainer in version 3.5+
                mkdir -p /scratch
                mkdir -p /QRISdata
                mkdir -p /sw
                mkdir -p /sw7
                mkdir -p /groups

                # mkdir -p /bin
                # ln -s ${pkgs.runtimeShell} /bin/bash
              '';

          };
        };

        devShells."x86_64-linux" = {
          r-shell =
            pkgs.mkShell {
              name = "r-shell";
              version = "1";
              packages = [
              ];
              buildInputs = allpackages ++ [
                python-tensorflow
              ];
              shellHook = ''
                export RETICULATE_PYTHON=${python-tensorflow}/bin/python3.11
                export PYTHONPATH="${python-tensorflow}/lib/python3.11:${python-tensorflow}/lib/python3.11/site-packages"
            '';
            };



        };
      };
}
