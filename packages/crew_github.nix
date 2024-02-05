{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    cli
    data_table
    getip
    mirai
    nanonext
    processx
    ps
    R6
    rlang
    tibble
    tidyselect
  ];

  sysdepends = with pkgs;[

  ];


in
pkgs.RmkDerive {

  name = "crew";

  version = "0.8.0.9003";

  src = pkgs.fetchFromGitHub {
    owner = "wlandau";
    repo = "crew";
    rev = "f0f6197ee461e5ca53d4098bc845c4a1f79cbc6d";
    sha256 =  "sha256-ORwAaQ/7xttabA+5wN10AVyVGWsHSWXx6pMuA1Ksegk=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
