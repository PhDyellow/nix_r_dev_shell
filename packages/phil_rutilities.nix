{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    archivist
    git2r
    dplyr
    tidyr
    stringr
  ];

  sysdepends = with pkgs;[
  ];


in

pkgs.RmkDerive {

  name = "phil_rutilities";

  version = "0.0.0.9000";

  src = pkgs.fetchFromGitHub {
    owner = "PhDyellow";
    repo = "rutilities";
    rev = "ff62709d2086d87287f490f38d50b71f7093dd72";
    sha256 = "sha256-9SzbC52DkabfzRf+QcikFLIBLF8mag2efpodJGf6LYs=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
