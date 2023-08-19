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
    rev =  "b2b2b2e0e7b9b50300a1d59e4d9d2542e27b5055";
    };
  depends = sysdepends ++ Rdepends;
}
