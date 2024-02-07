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

  src = pkgs.fetchFromGitHub {
    owner = "PhDyellow";
    repo = "rmethods";
    rev = "bd38f24a7e927dc483d923b847c6d21c38121463";
    sha256 = "sha256-OwlPtEvfZMUe6E8rzFQW4seJNhIE/zkREmk3nBKvslw=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
