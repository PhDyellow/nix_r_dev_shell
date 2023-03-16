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
    rev = "3c23cc7e99ddd6ab6b53a737de790c3bce1a6378";
    ref = "develop";
  };

  depends = sysdepends ++ Rdepends;

}
