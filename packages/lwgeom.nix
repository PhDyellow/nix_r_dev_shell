{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    Rcpp
    units
    sf
    #proj4
  ];

  sysdepends = with pkgs;[
    proj.dev
    proj
    pkgconfig
    geos
    sqlite
  ];

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in

RmkDerive {

  name = "lwgeom";

  version = "0.1.2";

  src = pkgs.fetchFromGitHub {
  owner = "r-spatial";
  repo = "lwgeom";
    rev = "3c5ff33e614b266e9f60d4020de719c898ccef7a";
    sha256 =  "0444v9s9pmmby4idxx1lskxlxmsrpfaj1nqx4m4jz1xmfp5vnf7f";
    fetchSubmodules = true;
  };


  depends = sysdepends ++ Rdepends;

}
