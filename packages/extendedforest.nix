{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    RColorBrewer
    MASS
    lattice
  ];

  sysdepends = with pkgs;[
  ];

  rev = "9c31980442befcc5d42890d2289ae705b67fe21c";

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in

RmkDerive {

  name = "extended_forest";

  version = "1.6.1";

  src = pkgs.fetchFromGitHub {
    owner = "rforge";
    repo = "gradientforest";
    sha256 = "1c5ap24b54fxpsl16ad8w4vphnick7kwjjakk2bdmjxr5zykfrcv";
    rev = rev;
  } + "/pkg/extendedForest";

  rev = rev;

  depends = sysdepends ++ Rdepends;
}
