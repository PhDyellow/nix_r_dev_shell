{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    gradientforest
    assertthat
  ];

  sysdepends = with pkgs;[
  ];


in

pkgs.RmkDerive {

  name = "castcluster";

  version = "0.0.0.9000";

  src = builtins.fetchGit {
    url = "git@github.com:MathMarEcol/CastCluster.git";
    ref = "refs/heads/develop";
    rev = "0c603b796df255eadb7292e249d8fca7f1685ac5";
    };


  depends = sysdepends ++ Rdepends;

}
