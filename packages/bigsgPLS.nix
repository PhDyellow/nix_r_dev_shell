{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    bigmemory
    expm
    irlba
    Matrix
    foreach
    dummies
    pryr
  ];

  sysdepends = with pkgs;[

  ];


in
pkgs.RmkDerive {

  name = "bigsgPLS";

  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
  owner = "matt-sutton";
  repo = "bigsgPLS";
    rev = "ddded0fedf94a4b0c93b916f077ddb74a99cc7bf";
    sha256 =  "04plm3ywmrv96i9w0zl2zqyrmd3v99hhpmvyqvp7dvnad1gnk4f1";
    fetchSubmodules = true;
  };

  depends = sysdepends ++ Rdepends;

}
