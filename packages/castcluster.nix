{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    gradientforest
    assertthat
    future_apply
    ggplot2
    ggthemes
  ];

  sysdepends = with pkgs;[
  ];


in

pkgs.RmkDerive {

  name = "castcluster";

  version = "0.0.0.9000";

  src = pkgs.fetchFromGitHub {
    owner = "MathMarEcol";
    repo = "CastCluster";
    rev = "c26edf04cc0a48f9daa158a053ba004a6fe816dc";
    sha256 =  "sha256-30f8Cd7xii9MgY5ubjMepAzcXJY8WpIxtaCG3vMoJhA=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
