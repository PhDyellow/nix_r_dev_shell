{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    mvtnorm
  ];

  sysdepends = with pkgs;[
  ];

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in
RmkDerive {

  name = "r-emmix";

  version = "1.0.2.15";

  src = pkgs.fetchFromGitHub {
  owner = "suren-rathnayake";
  repo = "EMMIX";
    rev = "eae22c66be72d9f29563dbb912f4500e927e6c8e";
    sha256 =  "1pxjypfvlniwaj5qby2lxq36spx2lbkbrlj990hv5sks4l8sjdwj";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;
}
