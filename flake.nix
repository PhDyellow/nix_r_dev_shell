{
  description = "Nix shell for working with R projects";

  inputs = {

    nixpkgs-unstable = {
      # url = "github:NixOS/nixpkgs/nixos-unstable";
      # url = "github:NixOS/nixpkgs/master";
      # url = "github:PhDyellow/nixpkgs?rev=1b886e9f282c1d912ab233883f345c2d65c15964";
      # url = "github:PhDyellow/nixpkgs/r-updates";
      url = "github:NixOS/nixpkgs/r-updates";
    };

  };

  outputs = {self, nixpkgs-unstable, ...}@inputs: {
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
      blas-lapack-amd = final: prev: {
        blas = prev.blas.override {
          blasProvider = final.amd-blis;
        };
        lapack = prev.lapack.override {
          lapackProvider = final.amd-libflame;
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
    };

    devShells."x86_64-linux" = {
      r-shell = let
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

            ## Only enable one of these. Nix will choose the last uncommented version
            ## Caching works if all are commented out
            # self.overlays.blas-lapack-mkl
            # self.overlays.blas-lapack-amd
            # self.overlays.blas-lapack-open
            (import ./packages/rpackages_overlay_flake.nix)
            # (import ./packages/gurobi_overlay.nix)
            (import ./packages/phantomjs2_overlay.nix) # Dropped from NixPkgs for being unmaintained and insecure. Needed by wdpar though
          ];
        };
        allpackages = (import ./all_packages.nix {pkgs = pkgs;});
        python-tensorflow = pkgs.python310.withPackages(ps: with ps; [
          tensorflow
          numpy
          keras
        ]);
          #   env = {
          #     RETICULATE_PYTHON = "${python-tensorflow}";
          #   };
      in
          pkgs.mkShell {
            name = "r-shell";
            version = "1";
            packages = [
            ];
            buildInputs = allpackages ++ [
              python-tensorflow
            ];
            shellHook = ''
              export RETICULATE_PYTHON=${python-tensorflow}/bin/python3.10
              export PYTHONPATH="${python-tensorflow}/lib/python3.10:${python-tensorflow}/lib/python3.10/site-packages"
            '';
        };



      };
    };
}
