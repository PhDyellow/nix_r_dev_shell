{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    narray
    progress
    purrr
    R6
    rzmq
  ];

  sysdepends = with pkgs;[
  ];

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in

RmkDerive {

  name = "clustermq";

  version = "0.2.9";

  src = pkgs.fetchFromGitHub {
  owner = "PhDyellow";
  repo = "clustermq";
    rev = "20bf18335e034bcf9e171a7c95d383f18da3bca2";
    sha256 =  "09rpv39wrmg6hcfs7r63m33ivhlp26bgk1gfabhlm9vwm099cw1d";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
