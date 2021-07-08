{R, pkgs}:
let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
  ];

  sysdepends = with pkgs;[
  ];

  rev = "c5e36cb40afd71fb073e3eb5eebdc89f9c2504f7";

  RmkDerive = pkgs.callPackage ./rmkderive.nix {
  };

in

RmkDerive {

  name = "nvimcom";

  version = "0.9.13.1";

  src = pkgs.fetchFromGitHub {
    owner = "jalvesaq";
    repo = "Nvim-R";
      rev = rev;
      sha256 = "1ckdsyp3ny0vq58zxhar0mrjmzpnwrfxg1vsk3f1s9dbdvlagiyq";
      fetchSubmodules = true;
  } + "/R/nvimcom/";

      rev = rev;

  depends = sysdepends ++ Rdepends;
}
