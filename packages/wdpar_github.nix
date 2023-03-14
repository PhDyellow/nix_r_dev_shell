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


in

pkgs.RmkDerive {

  name = "wdpar";

  version = "1.3.1.3";

  src = pkgs.fetchFromGitHub {
  owner = "prioritizr";
  repo = "wdpar";
    rev = "1bd7054140df6f830474b3bb35e9954953e75624";
    sha256 =  "1n7avrzsjnwpaanjpjs7f6q0mxs1k0yx4dyg41xggcsparpfbibi";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
