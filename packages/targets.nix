{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    callr
    cli
    codetools
    data.table
    digest
    igraph
    R6
    rlang
    stats
    tibble
    tidyselect
    utils
    vctrs
    withr
    yaml

    #Optional deps
    arrow
    clustermq
    curl
    dplyr
    fst
    future
    future.callr
    gt
    knitr
    markdown
    rmarkdown
    pingr
    pkgload
    qs
    testthat
    usethis
    visNetwork
  ];

  sysdepends = with pkgs;[
  ];


  RmkDerive = pkgs.callPackage ./rmkderive.nix {};

in

RmkDerive {

  name = "targets";

  version = "0.4.2";

  src = pkgs.fetchFromGitHub {
    owner = "ropensci";
    repo = "targets";
    ref = "refs/heads/main";
    rev = "bc809838ec6a5f4f2868fcf02ac21ce3454661db";
    sha256 = "0000000000000000000000000000000000000000000000000000";
    };
  depends = sysdepends ++ Rdepends;
}
