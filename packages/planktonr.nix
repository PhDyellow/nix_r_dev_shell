{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    data.table
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
    stats
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
    sha256 =  "0000000000000000000000000000000000000000000000000000";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;
}
