
{R, pkgs, gettext, libcxx}:

let
  inherit (pkgs) cacert fetchurl stdenv lib;

  Rdepends = with pkgs.rPackages; [
    Rcpp
  ];

  sysdepends = with pkgs;[
    clang
  ];

  RmkDerive = pkgs.callPackage ./rmkderive.nix {};

in
let
  buildInputs = Rdepends ++ sysdepends;
in
pkgs.stdenv.mkDerivation ({

  name = "rcpparmadillo-github";

  version = "0.9.700.2.0";

  src = pkgs.fetchFromGitHub {
      owner = "RcppCore";
      repo = "RcppArmadillo";
  rev = "ca33619fee6c8a367f6ac87fc289051ed932369f";
  sha256 = "008h3pimdd0fb4zxf3b123px5y6bxb40wghczyq7mmnwv4313dpj";
  fetchSubmodules = true;
    };

  buildInputs = buildInputs ++ [R gettext];

  configurePhase = ''
    runHook preConfigure
    export R_LIBS_SITE="$R_LIBS_SITE''${R_LIBS_SITE:+:}$out/library"
    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild
    runHook postBuild
  '';

  patchPhase = "patchShebangs configure";

  configureFlags = [];
  installFlags = ["--configure-vars=CPPFLAGS=-O3"];

  rCommand = "R";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/library
    $rCommand CMD INSTALL $installFlags --configure-args="$configureFlags" -l $out/library .
    runHook postInstall
  '';

  postFixup = ''
    if test -e $out/nix-support/propagated-build-inputs; then
        ln -s $out/nix-support/propagated-build-inputs $out/nix-support/propagated-user-env-packages
    fi
  '';

  checkPhase = ''
    # noop since R CMD INSTALL tests packages
  '';
})

# {R, pkgs}:

# let
#   inherit (pkgs) cacert fetchurl stdenv lib;

#   Rdepends = with pkgs.rPackages; [
#     Rcpp
#   ];

#   sysdepends = with pkgs;[
#     clang
#   ];


#   RmkDerive = pkgs.callPackage ./rmkderive.nix {};

# in

# RmkDerive {

#   name = "rcpparmadillo-github";

#   version = "0.9.700.2.0";

#   src = pkgs.fetchFromGitHub {
#       owner = "RcppCore";
#       repo = "RcppArmadillo";
#   rev = "ca33619fee6c8a367f6ac87fc289051ed932369f";
#   sha256 = "008h3pimdd0fb4zxf3b123px5y6bxb40wghczyq7mmnwv4313dpj";
#   fetchSubmodules = true;
#     };

#   depends = sysdepends ++ Rdepends;

# }
