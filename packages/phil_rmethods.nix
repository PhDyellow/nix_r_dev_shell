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


  RmkDerive = pkgs.callPackage ./rmkderive.nix {};

in

RmkDerive {

  name = "phil_rmethods";

  version = "0.0.0.9000";

  src = builtins.fetchGit {
    url = "git@github.com:PhDyellow/rmethods.git";
  #rev = "81257d565e4076addf75d7062043046c57b1663b";
  ref = "develop";
    };

  depends = sysdepends ++ Rdepends;

}
