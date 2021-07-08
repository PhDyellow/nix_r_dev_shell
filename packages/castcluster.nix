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
    rev = "47573424ba26b792b54d598a5c06c1da62981f7a";
    };


  depends = sysdepends ++ Rdepends;

}
