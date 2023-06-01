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
    rev = "15563d1725d0224a591750cce54cf2ce7ce9f007";
    };


  depends = sysdepends ++ Rdepends;

}
