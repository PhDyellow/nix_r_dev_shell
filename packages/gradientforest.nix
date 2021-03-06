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

    rev = "a87f428cbb78f80522fdc7672d205d2d2e263dc3";

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in

RmkDerive {

  name = "gradient_forest";

  version = "0.1.20";

  src = builtins.fetchGit {
    url = "git@github.com:PhDyellow/gradientforestgitsvn.git";
    rev = rev;
    ref = "master";
  } + "/pkg/gradientForest";

  # src = pkgs.fetchFromGitHub {
  #   owner = "PhDyellow";
  #   repo = "gradientforestgitsvn";
  #   sha256 = "07myvj402zrby2y8s6lyia2pkdsv82kg44w7jla63bywa8m0y2cs";
  #   rev = rev;
  # } + "/pkg/gradientForest";

  rev = rev;

  depends = sysdepends ++ Rdepends;
}
