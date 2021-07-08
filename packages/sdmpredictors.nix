{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    raster
    rgdal
    R_utils
  ];
   
  sysdepends = with pkgs;[
  ];

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in

RmkDerive {

  name = "sdm-predictors-github";


  version = "0.2.8";

  src = pkgs.fetchFromGitHub {
      owner = "lifewatch";
      repo = "sdmpredictors";
  rev = "8797bb761ef83e0991e94f748475a93451405313";
  sha256 = "1gpxc5hal6qvn72tp75fd4a4pw1b79kbhx30d5nfl86iy43l4pfq";
  fetchSubmodules = true;
    };

  depends = sysdepends ++ Rdepends;
}
