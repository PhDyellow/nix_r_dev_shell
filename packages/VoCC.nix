{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    raster
    CircStats
    cowplot
    data_table
    doParallel
    fields
    foreach
    gdistance
    geosphere
    ggplot2
    matrixStats
    RColorBrewer
    rgdal
    sp
    xts
  ];

  sysdepends = with pkgs;[
  ];


in

pkgs.RmkDerive {

  name = "VoCC";

  version = "0.3.7";

  src = pkgs.fetchFromGitHub {
  owner = "JorGarMol";
  repo = "VoCC";
    rev = "e19381c60783decb9890c4076335074689344c08";
    sha256 =  "0aj5nbxbigy7icr32jx1h9421yrjv19v8sripmhdxk1b00vffd1z";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
