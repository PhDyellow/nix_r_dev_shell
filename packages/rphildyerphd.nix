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
    rev = "24f2750f323013e6f69ddd10e25dfa513d7c1080";
    sha256 = "sha256-fbfcR9k/o4Z6E8hPpaLvpDY8Sf1RWMcTV94Pe/ZXLv4=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
