{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    base64url
    callr
    cli
    codetools
    data_table
    digest
    igraph
    knitr
    R6
    rlang
    tibble
    tidyselect
    vctrs
    yaml
  ];

  sysdepends = with pkgs;[

  ];


in
pkgs.RmkDerive {

  name = "targets";

  version = "1.4.1.9002";

  src = pkgs.fetchFromGitHub {
    owner = "ropensci";
    repo = "targets";
    rev = "b9e22202fbd24f7341714b287954a782716dfa0e";
    sha256 =  lib.fakeHash;
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
