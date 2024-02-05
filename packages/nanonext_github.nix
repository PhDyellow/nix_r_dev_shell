{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
  ];

  sysdepends = with pkgs;[
    mbedtls
    nng
  ];


in
pkgs.RmkDerive {

  name = "nanonext";

  version = "0.12.0.9019";
  src = pkgs.fetchFromGitHub {
  owner = "shikokuchuo";
    repo = "nanonext";
    rev = "b56bb3be5c5835d07d84ab0a2e130b1c639026f7";
    sha256 =  "sha256-gEsr4y/DPm+RX+nyMjKkEtJY87avbd3SF8BR2Dy3GSg=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
