{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    assertthat
    vegan
    gradientforest
    # mvpart
    foreach
    clue
  ];

  sysdepends = with pkgs;[
  ];


in

pkgs.RmkDerive {

  name = "rphildyerphd";

  version = "0.0.0.9000";
  src = pkgs.fetchFromGitHub {
    owner = "PhDyellow";
    repo = "rphildyerphd";
    rev = "64c852f132e81722f11c387b9904d644930e22c4";
    sha256 = "sha256-lBCCg8jwf/5rlgIz9m18h895HWkwvMTRaewkpQn5acw=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
