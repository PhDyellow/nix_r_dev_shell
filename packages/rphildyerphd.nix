{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    assertthat
    vegan
    gradientforest
    mvpart
    foreach
    clue
  ];

  sysdepends = with pkgs;[
  ];


  RmkDerive = pkgs.callPackage ./rmkderive.nix {};

in

RmkDerive {

  name = "rphildyerphd";

  version = "0.0.0.9000";

  src = builtins.fetchGit {
    url = "git@github.com:MathMarEcol/rphildyerphd.git";
    ref = "develop";
    rev = "158ba48b459f5b1cc3c3ed035187df184e474fea";
    };

  depends = sysdepends ++ Rdepends;

}
