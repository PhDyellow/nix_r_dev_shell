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


in

pkgs.RmkDerive {

  name = "gfbootstrap";

  version = "0.0.0.9000";

  src = builtins.fetchGit {
    url = "git@github.com:MathMarEcol/gfbootstrap.git";
    ref = "refs/heads/develop";
    rev =  "d2a32232a67531d7bcaf8019f63892c20eaf1955";
    };
  depends = sysdepends ++ Rdepends;
}
