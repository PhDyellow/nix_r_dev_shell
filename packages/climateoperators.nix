{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    raster
    lubridate
    codetools
  ];

  sysdepends = with pkgs;[
    cdo
    nco
  ];


  RmkDerive = pkgs.callPackage ./rmkderive.nix {};

in

RmkDerive {

  name = "climateoperators-github";

  version = "0.2.2";

  src = pkgs.fetchFromGitHub {
      owner = "markpayneatwork";
      repo = "ClimateOperators";
  rev = "244ebaba6cddc678c31742f62b750972fcb7ad0d";
  sha256 = "05a98achvkp4szc719vq5mh00m48jxdf370614p1fhnx38jjdl15";
  fetchSubmodules = true;
    };

  depends = sysdepends ++ Rdepends;

}
