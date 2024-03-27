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

    nix-gl-host = {
      url = "github:numtide/nix-gl-host";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
      rpackages = (import ./r_packages.nix { pkgs = pkgs; });

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

        packages."x86_64-linux" = {
          r_with_packages_test = pkgs.rWrapper.override {
            packages = rpackages;
          };

          radian_with_packages =
            pkgs.stdenv.mkDerivation {
              name = "radian_contained";
              buildInputs = allpackages ++ [
                # python-tensorflow
                inputs.nix-gl-host.defaultPackage.x86_64-linux

              ];
              meta.mainProgram = "radian";
              dontUnpack = true;
              dontConfigure = true;
              dontPatch = true;
              dontBuild = true;
            };
          r_shell_app = pkgs.symlinkJoin {
            name = "r_as_sym_set";
            paths = allpackages;
          };
        };

        apps."x86_64-linux" = {
          r_shell_wrapped = {
            type = "app";
            program = "${self.packages.x86_64-linux.r_shell_app}/bin/bash";
          };



          R_with_packages = {
            type = "app";
            program = pkgs.stdenv.mkDerivation {
              name = "R_with_packages";

              version = "1";
              packages = [
              ];
              buildInputs = allpackages ++ [
                # python-tensorflow
                inputs.nix-gl-host.defaultPackage.x86_64-linux

              ];

              meta.mainProgram = "radian";

            };
          };

              


              

              ## This needs to be a binary in a store path.
              ## I need to generate an R binary (wrapped) with the appropriate environment, without relying on a shell.
             #  "${(pkgs.radianWrapper.overrideAttrs (_: {
          #       buildInputs = with pkgs; [
          #         bashInteractive

          #                   binutils
          # coreutils
          # util-linux
          # inetutils

          # pandoc #needed for rMarkdown

          # cairo #for httpdg package

          # #gnutar
          # #gzip
          # #gnumake
          # #gcc
          # #gawk
          # #gnused
          # #glibc
          # #glibcLocales

          # which #explicity include which that R compiled against, rather than fall back to system `which``, for some reason the Rshell which and system which are not identical
          # less


          # _7zz # used by shell scripts to minimise small files on HPC filesystems

          # #needs a shell in the container
          # # bashInteractive
          # # bash_5

          # # gurobi

          # ## Functions to work with climate data
          # cdo
          # # nco

          # curl
          # wget
          # openssh
          # openssl
          # iputils
          # cacert

          # phantomjs2 ## hack for wdman, needed by wdpar. Dropped wdpar because nix no longer supports phantomjs
          # #also hack for wdman, should pull in selenium
          # selenium-server-standalone
          # chromedriver
          # htmlunit-driver

          # squashfsTools

          #       ] ++ _.buildInputs ++ allpackages;
          #       })).override {
          #       packages = [
          #       ] ++ rpackages;
          #       wrapR = true;
          #       }}/bin/R";

          # };
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
                inputs.nix-gl-host.defaultPackage.x86_64-linux
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
                echo "export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" >> /.singularity.d/env/90-environment.sh
                # echo "export RETICULATE_PYTHON=${python-tensorflow}/bin/python3.11" >> /.singularity.d/env/90-environment.sh
                # echo "export PYTHONPATH=${python-tensorflow}/lib/python3.11:${python-tensorflow}/lib/python3.11/site-packages" >> /.singularity.d/env/90-environment.sh
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
                # python-tensorflow
                inputs.nix-gl-host.defaultPackage.x86_64-linux

              ];
              shellHook = ''
                export RETICULATE_PYTHON=${python-tensorflow}/bin/python3.11
                export PYTHONPATH="${python-tensorflow}/lib/python3.11:${python-tensorflow}/lib/python3.11/site-packages"
            '';
            };
        };
      };
}
