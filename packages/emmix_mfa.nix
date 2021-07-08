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

  name = "r-emmix-mfa";

  version = "2.0.0";
  src = pkgs.fetchurl {
    url = "file:///vmshare/cust-nix/Rshell/packages/EMMIXmfa_2.0.0.tar.gz";
    sha256 =  "0iyp3sdzxn6kdssx390lb6xlkq4wcmqcqw6y7648i4ffr2yl706w";
  };


  depends = sysdepends ++ Rdepends;
}
