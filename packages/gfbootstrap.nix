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
    rev =  "2806dfbc76dfd048b2cd63b9759a02d3e250d38e";
    };
  depends = sysdepends ++ Rdepends;
}
