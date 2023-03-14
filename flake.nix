{
  description = "Nix shell for working with R projects";

  inputs = {

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    r-radian = {
      url = "github:swt30/radian-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };


  };

  outputs = {self, nixpkgs-unstable, ...}@inputs: {
#    overlays.r_packages = import ./packages/rpackages_overlay_flake.nix;

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
            (import ./packages/rpackages_overlay_flake.nix)
            (import ./packages/gurobi_overlay.nix)
            (import ./packages/phantomjs2_overlay.nix) # Dropped from NixPkgs for being unmaintained and insecure. Needed by wdpar though
            #(import ./packages/intel_mkl_overlay.nix)
            #(import ./packages/qemu_overlay.nix)
          ];

        };
        allpackages = (import ./all_packages.nix {pkgs = pkgs;});
        in
          pkgs.mkShell {
            name = "r-shell";
            version = "1";
            packages = [
              inputs.r-radian.x86_64-linux.packages.radian
            ];
            buildInputs = allpackages ++ [
            ];
        };



      };
    };
}
