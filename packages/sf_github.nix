{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    Rcpp
    classInt
    DBI
    magrittr
    units
  ];

  sysdepends = with pkgs;[
    pkgconfig
    proj
    geos
    gdal
    sqlite
  ];

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in

RmkDerive {

  name = "sf-github";

  version = "0.9.6";

  src = pkgs.fetchFromGitHub {
      owner = "r-spatial";
      repo = "sf";
  rev = "bb5e245d7d2f5193d9f27d63ddf4cb35d375737a";
  sha256 = "1dbkrlmd5lmchl81kqlm2kgw3lslnafdjr99br2rc0xhww9xshy1";
  fetchSubmodules = true;
    };

  depends = sysdepends ++ Rdepends;
}
