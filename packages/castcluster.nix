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
    rev = "2ba05b57c59453e1a333fe05bb479997e49f5f83";
    };


  depends = sysdepends ++ Rdepends;

}
