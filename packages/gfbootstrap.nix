{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    gradientforest
    assertthat
    future_apply
  ];

  sysdepends = with pkgs;[
  ];


  RmkDerive = pkgs.callPackage ./rmkderive.nix {};

in

RmkDerive {

  name = "gfbootstrap";

  version = "0.0.0.9000";

  src = builtins.fetchGit {
    url = "git@github.com:MathMarEcol/gfbootstrap.git";
    ref = "refs/heads/develop";
    rev = "2df5b802fcefa45c62a51d6a5ba55d1865fe6406";
    };
  depends = sysdepends ++ Rdepends;
}
