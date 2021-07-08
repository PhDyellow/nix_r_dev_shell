{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    R6
    processx
  ];

  sysdepends = with pkgs;[
  ];

  rev = "e705cc287647acfe21b6b6eaaca5f7015c354597";
  RmkDerive = pkgs.callPackage ./rmkderive.nix {};

in
RmkDerive {

  name = "callr-github";

  version = "3.2.0";

  src = pkgs.fetchFromGitHub{
    owner = "r-lib";
    repo = "callr";
    rev = rev;
    sha256 = "14jsl84yd6mmqivl881bamc7m1yr01m4i49i3lj3pkz0w6apgm5x";
  };

  rev = rev;
  depends = sysdepends ++ Rdepends;
}
