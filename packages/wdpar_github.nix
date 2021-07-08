{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    sf
    testthat
    knitr
    roxygen2
    rmarkdown
    ggmap
    ggplot2
    pingr
    #utils ## Base package
    #tools ## Base package
    sp
    assertthat
    progress
    curl
    rappdirs
    httr
    countrycode
    wdman
    RSelenium
    xml2
    cli
    lwgeom
    tibble
    withr
  ];

  sysdepends = with pkgs;[
  ];

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in

RmkDerive {

  name = "wdpar";

  version = "1.3.0.1";

  src = pkgs.fetchFromGitHub {
  owner = "prioritizr";
  repo = "wdpar";
    rev = "a1022d7db5c60f52bfce26931c8cb5f7a303720b";
    sha256 =  "1nclrzmfcrdx2m0kmww8j98rxa1pdnxjddhlr8x4fv3p04wfncc3";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
