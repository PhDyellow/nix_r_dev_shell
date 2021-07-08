{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    survival
  ];

  sysdepends = with pkgs;[
  ];


  RmkDerive = pkgs.callPackage ./rmkderive.nix {};

in

RmkDerive {

  name = "mvpart-github";

  version = "1.6.2";

  src = pkgs.fetchFromGitHub {
      owner = "cran";
      repo = "mvpart";
  rev = "acf0035fc7d002da46e4df5e4f4a77f04432f40e";
  sha256 = "17rmcdccrqyq70vl1iiimw9fa3rda542h3g4hn1575hwpyhxgijf";
  fetchSubmodules = true;
    };

  depends = sysdepends ++ Rdepends;

}
