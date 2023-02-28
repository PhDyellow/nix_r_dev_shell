{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    data_table
    dplyr
    ggplot2
    htmltools
    leaflegend
    leaflet
    lubridate
    lutz
    magrittr
    patchwork
    purrr
    readr
    rlang
    rnaturalearth
    sf
#    stats # r core package
    stringr
    suncalc
    tibble
    tidyr
    tidyselect
    units
    covr
    knitr
    pracma
    rmarkdown
    rnaturalearthdata
    RNetCDF
    testthat
    thredds
    yaImpute
    zoo
    knitr
  ];

  sysdepends = with pkgs;[
  ];

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in
RmkDerive {

  name = "r-planktonr";

  version = "0.5.3.0000";

  src = pkgs.fetchFromGitHub {
  owner = "PlanktonTeam";
  repo = "planktonr";
    rev = "c0dc406c460c44eebd60806c96364a8ba7734137";
    sha256 =  "sha256-b12lMIrQHpWXRyrQDQIWTd5X9bKLHSmxEF1bYnldpfU=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;
}
