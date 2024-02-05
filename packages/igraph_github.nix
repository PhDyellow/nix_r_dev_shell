{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    cli
    lifecycle
    cpp11
    magrittr
    Matrix
    pkgconfig
    rlang
    devtools
    irlba
    roxygen2
    covr
    readr
    knitr
  ];

  sysdepends = with pkgs;[
    gmp
    glpk
    libxml2.dev
    which
  ];


in
pkgs.RmkDerive {

  name = "igraph";

  version = "2.0.1.9004";

  src = pkgs.fetchFromGitHub {
    owner = "igraph";
    repo = "rigraph";
    rev = "1eb74e3a5b848b866205dd9fc5ebe5bdb12924de";
    sha256 =  "sha256-DHGKvrhvnVGU+ybuK6n6JiVVOICmLuJyR0tW01ZGr78=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
