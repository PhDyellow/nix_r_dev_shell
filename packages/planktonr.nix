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


in
pkgs.RmkDerive {

  name = "r-planktonr";

  version = "0.5.6.0000";

  src = pkgs.fetchFromGitHub {
  owner = "PlanktonTeam";
  repo = "planktonr";
  rev = "82076c066b023b8387ba584bbd8a7a72cd99b2d2";
    sha256 =  "sha256-WF2mz6ZzLmewtQUD0xEUZq8/8pQa8T97wBrZb5Asbb8=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;
}
