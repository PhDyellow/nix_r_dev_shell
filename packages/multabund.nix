{pkgs}:
let
  Rdepends = with pkgs.rPackages; [
    Rcpp
    copula
    #(pkgs.callPackage ./ggplot2.nix {})
    ggplot2
    cowplot
    magrittr
    reshape2
    knitr
    rmarkdown
    ggdendro
    RcppArmadillo
    RcppProgress
  ];
in
pkgs.stdenv.mkDerivation rec {

  name = "r-multAbund";

  version = "0.0.02";

  src = pkgs.fetchFromGitHub {
      owner = "dsjohnson";
      repo = "multAbund";
  rev = "6fc804fa1051dfec29c3b6093bf08607e5156a30";
  sha256 = "1analmps88hzf17xhy3i9h8p6c841r9djqj95n6zyafw2gm03553";
  fetchSubmodules = true;
    };

  nativeBuildInputs = with pkgs; [
  gnutar
  gzip
  gnumake
  gcc
  binutils
  coreutils
  gawk
  gnused
  stdenv
    R
    #clang
    #libcxx
    xvfb_run
    utillinux
    gettext
    gfortran
  ] ++ Rdepends;

  propagatedBuildInputs = [
    pkgs.R
  ] ++ Rdepends;

  #configureFlags = "CXXFLAGS=-g -O -mtune=native CFLAGS=-g -O -mtune=native";

  NIX_CFLAGS_COMPILE =
    pkgs.lib.optionalString pkgs.stdenv.isDarwin "-I${pkgs.libcxx}/include/c++/v1";

  configurePhase = ''
    runHook preConfigure
    export R_LIBS_SITE="$R_LIBS_SITE''${R_LIBS_SITE:+:}$out/library"
    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild
    runHook postBuild
  '';

  installFlags = [];

  rCommand = "R";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/library
    $rCommand CMD INSTALL $installFlags --configure-args="$configureFlags" -l $out/library .
    runHook postInstall
  '';

  postFixup = ''
    if test -e $out/nix-support/propagated-native-build-inputs; then
        ln -s $out/nix-support/propagated-native-build-inputs $out/nix-support/propagated-user-env-packages
    fi
  '';

  checkPhase = ''
    # noop since R CMD INSTALL tests packages
  '';
}
