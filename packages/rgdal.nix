{R, pkgs, proj, proj-datumgrid, gdal}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    sp
  ];

  sysdepends = with pkgs;[
		proj
		proj-datumgrid
    gdal
    sqlite
  ];

  rev = "c3a55f71cc9d88f963aafbe086a1351e0cf52491";

  RmkDerive = pkgs.callPackage ./rmkderive.nix {};

in
RmkDerive {

  name = "rgdal-github";

  version = "1.4.5";

  src = pkgs.fetchFromGitHub{
    owner = "rforge";
    repo = "rgdal";
    rev = rev;
    sha256 = "1jbzgzdrfcv9yk156hgnwyvajk4bzaxjbx7da4zwycl28jxgq18s";
  } + "/pkg";

  rev = rev;

  depends = sysdepends ++ Rdepends;
}
