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

    devShells."x86_64-linux" = {
      r-shell = let
        pkgs = import nixpkgs-unstable {system = "x86_64-linux";};
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
