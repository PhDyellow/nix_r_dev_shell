{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
  ];

  sysdepends = with pkgs;[

  ];


in
pkgs.RmkDerive {

  name = "secretbase";

  version = "0.2.0";

  src = pkgs.fetchFromGitHub {
    owner = "shikokuchuo";
    repo = "secretbase";
    rev = "ced25de47a85c2e4dd27381dabc75fa5135451e8";
    sha256 =  "sha256-0h/WmGTHrkde6rNeTwbUVgMeEOGrEzYxu56JCubSzfo=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
