{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    ape
    assertthat
    BH
    data_table
    doParallel
    exactextractr
    fasterize
    igraph
    magrittr
    Matrix
    plyr
    proto
    raster
    Rcpp
    RcppArmadillo
    rgeos
    sf
    sp
    tibble
    uuid
    withr
    codetools
  ];

  sysdepends = with pkgs;[
  ];

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in

RmkDerive {

  name = "prioritizr";

  version = "6.0.0";

  src = pkgs.fetchFromGitHub {
  owner = "prioritizr";
  repo = "prioritizr";
    rev = "ef165baf4afda6f0d656a15722b691f9e77071a8";
    sha256 =  "0f69il0aqjw1ampl44p387h8imf1mn9yqlyp0ncja4hgx1f5kcrh";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
