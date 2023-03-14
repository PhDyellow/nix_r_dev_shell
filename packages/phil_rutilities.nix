{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    archivist
    git2r
    dplyr
    tidyr
    stringr
  ];

  sysdepends = with pkgs;[
  ];


in

pkgs.RmkDerive {

  name = "phil_rutilities";

  version = "0.0.0.9000";

  src = builtins.fetchGit {
    url = "git@github.com:PhDyellow/rutilities.git";
    # rev = "f049d3e9ea8d96551a50aa5c67fed8d0e52384be";
    ref = "develop";
  };

  depends = sysdepends ++ Rdepends;

}
