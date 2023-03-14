{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    testthat
    xml2
    fontquiver
    covr
    knitr
    rmarkdown
    systemfonts
  ];

  sysdepends = with pkgs;[
    fontconfig
    libpng
    cairo
    freetype2
  ];


in

pkgs.RmkDerive {

  name = "unigd-github";

  version = "0.1.0.9000";

  src = pkgs.fetchFromGitHub {
      owner = "nx10";
      repo = "unigd";
  rev = "491cd471564f55627386d849d81e408aa03c00de";
  sha256 = "0000000000000000000000000000000000000000000000000000";
  fetchSubmodules = true;
    };

  depends = sysdepends ++ Rdepends;

}
