#call this shell with
#/vmshare/PARA/projects/nix_shell_pin/nix_shell_pin.sh r_shell.nix ~/.nixshellgc
{ pkgs
  ? import ./nixpkgs_rev.nix
}:

let
  name = "r-singularity-aus_bio-shell";
#  rpackages = (import ./r_packages.nix {pkgs = pkgs;}); #already in all_packages, but used here for RStudio
  allpackages = (import ./all_packages.nix {pkgs = pkgs;});
in 
pkgs.mkShell {
  name = name;
  version = "1";

  nativeBuildInputs = with pkgs; [
  ];
  buildInputs = allpackages ++ [
    #(pkgs.callPackage ./nix_r_compact_libs.nix {rPa = rpackages;})
    # (pkgs.rstudioWrapper.override {
    #   packages = [
    #   ] ++ rpackages;
    # })
  ];
  shellHook = ''
  export GUROBI_HOME=${pkgs.gurobi}
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$GUROBI_HOME/lib"
'';
  }

