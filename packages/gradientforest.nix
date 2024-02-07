{R, pkgs}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    lattice
    cluster
    (pkgs.callPackage ./extendedforest.nix {})
  ];

  sysdepends = with pkgs;[
  ];

  rev = "51f71459ed866d7a5de1265f1c27e0de689f1abc";

  repo = pkgs.fetchFromGitHub {
    owner = "PhDyellow";
    repo = "gradientforestgitsvn";
    sha256 = "sha256-8U0Fbw82uUEwiBU1TzQAclxPay2qk1gU28hgdpDTAJc=";
    rev = rev;
  };

in

pkgs.RmkDerive {

  name = "gradient_forest";

  version = "0.1.37";

  src = "${repo}/pkg/gradientForest";
  rev = rev;
  depends = sysdepends ++ Rdepends;
}
