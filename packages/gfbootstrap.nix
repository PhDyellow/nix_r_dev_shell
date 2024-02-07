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

  src = pkgs.fetchFromGitHub {
    owner = "MathMarEcol";
    repo = "gfbootstrap";
    rev = "32c82e2cb418a2e16735bce738199461a3f9bdc8";
    sha256 = "sha256-WY6TNrjAwNS2F+NqvLwE2UDBvzuMPw3lbhscO4kgsTI=";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;
}
