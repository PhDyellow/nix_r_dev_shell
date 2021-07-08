{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    callr
    collections
    desc
    jsonlite
    lintr
    R6
    repr
    stringr
    styler
    fs
    roxygen2
    covr
    magrittr
    mockery
    processx
    purrr
    testthat
    withr
  ];

  sysdepends = with pkgs;[
  ];

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in

RmkDerive {

  name = "languageserver";

  version = "0.3.7";

  src = pkgs.fetchFromGitHub {
  owner = "REditorSupport";
  repo = "languageserver";
    rev = "fd50e5e2798fc1de903caf55ecf9185ed375d047";
    sha256 =  "0jyrp39lm2lps1wwbd41fbrmbachdkki7pc3526m3n42xnbsh47n";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
