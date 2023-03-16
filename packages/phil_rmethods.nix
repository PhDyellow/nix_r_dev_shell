{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
  data_table
  ellipse
  foreach
  ggcorrplot
  ggplot2
  lubridate
  mclust
  raster
  reshape2
  fields
  gradientforest
  MASS
  # seaaroundus
  sdmpredictors
  testthat
  ];

  sysdepends = with pkgs;[
  ];


in

pkgs.RmkDerive {

  name = "phil_rmethods";

  version = "0.0.0.9000";

  src = builtins.fetchGit {
    url = "git@github.com:PhDyellow/rmethods.git";
  rev = "3b7eb61d6e7ded3ca71789897f69f0cd65f19791";
  ref = "develop";
    };

  depends = sysdepends ++ Rdepends;

}
