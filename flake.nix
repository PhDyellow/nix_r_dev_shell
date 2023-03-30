{
  description = "Nix shell for working with R projects";

  inputs = {

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
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
    };

    devShells."x86_64-linux" = {
      r-shell = let
        pkgs = import nixpkgs-unstable {
          system = "x86_64-linux";
          config = {
            allowUnfree= true;
            permittedInsecurePackages = [
              "python-2.7.18.6-env"
              "python-2.7.18.6"
            ];
          };
          overlays = [
            self.overlays.buildRPackage
            (import ./packages/rpackages_overlay_flake.nix)
            (import ./packages/gurobi_overlay.nix)
            (import ./packages/phantomjs2_overlay.nix) # Dropped from NixPkgs for being unmaintained and insecure. Needed by wdpar though
          ];
        };
        allpackages = (import ./all_packages.nix {pkgs = pkgs;});
        in
          pkgs.mkShell {
            name = "r-shell";
            version = "1";
            packages = [
              inputs.r-radian.packages.x86_64-linux.radian
            ];
            buildInputs = allpackages ++ [
            ];
        };



      };
    };
}
