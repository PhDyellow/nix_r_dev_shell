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

  rev = "721a8ecd5bee4f9440325412fce4aac8db1862b9";


in

pkgs.RmkDerive {

  name = "extended_forest";

  version = "1.6.2";

  src = pkgs.fetchFromGitHub {
    owner = "rforge";
    repo = "gradientforest";
    sha256 = "sha256-402JEGiKay3HDIAiCR1Kp9bs2mDgxXZZXYYEPAVcEbQ=";
    rev = rev;
  } + "/pkg/extendedForest";

  rev = rev;

  depends = sysdepends ++ Rdepends;
}
