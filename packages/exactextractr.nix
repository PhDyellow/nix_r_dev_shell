{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    Rcpp
    raster
    sf
  ];

  sysdepends = with pkgs;[
    geos
  ];

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in

RmkDerive {

  name = "exactextractr";

  version = "0.4.0";

  src = pkgs.fetchFromGitHub {
  owner = "isciences";
  repo = "exactextractr";
    rev = "4d8bd58d7e41abaa598fa8c1320ad9a8125e9ce3";
    sha256 =  "07lpakgkda1jmvwvq4f09s29k9lxggmpg1crsjkr9ysx6h8qrs0c";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
