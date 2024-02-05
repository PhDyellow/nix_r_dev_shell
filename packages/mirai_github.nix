{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    nanonext
  ];

  sysdepends = with pkgs;[

  ];


in
pkgs.RmkDerive {

  name = "mirai";

  version = "0.12.1";
  src = pkgs.fetchFromGitHub {
  owner = "shikokuchuo";
    repo = "mirai";
    rev = "2c7600c63a2c5bd9f29e4aa574dd787f9cdca51a";
    sha256 =  "sha256-Nq1ER4kLnRjWrgb6vTUSwCWuv1wu3BbtufBqdhh4S0k=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
