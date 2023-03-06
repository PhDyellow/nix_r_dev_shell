{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    gradientforest
    assertthat
  ];

  sysdepends = with pkgs;[
  ];


  RmkDerive = pkgs.callPackage ./rmkderive.nix {};

in

RmkDerive {

  name = "castcluster";

  version = "0.0.0.9000";

  src = builtins.fetchGit {
    url = "git@github.com:MathMarEcol/CastCluster.git";
    ref = "refs/heads/develop";
    rev = "e785035cc9ae07df9f9f5a0a31611b17f6396e1c";
    };


  depends = sysdepends ++ Rdepends;

}
