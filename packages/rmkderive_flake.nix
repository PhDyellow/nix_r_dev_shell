{R, pkgs, util-linux }:


let
  inherit (pkgs) cacert fetchurl stdenv lib util-linux;


  buildRPackage = pkgs.callPackage (nixpkgs-unstable + "pkgs/development/r-modules/generic-builder.nix") {
    inherit R;
    inherit (pkgs.darwin.apple_sdk.frameworks) Cocoa Foundation;
    inherit (pkgs) gettext gfortran;
  };

in


lib.makeOverridable ({
        name, version, src, rev ? "",
        depends ? [],
        doCheck ? true,
        requireX ? false,
        broken ? false,
        hydraPlatforms ? R.meta.hydraPlatforms
      }: buildRPackage {
    name = if "${rev}" != "" then "${name}-${version}-${rev}" else "${name}-${version}-${src.rev}";
    inherit doCheck requireX src;
    propagatedBuildInputs = depends;
    nativeBuildInputs = depends;
    meta.platforms = R.meta.platforms;
    meta.hydraPlatforms = hydraPlatforms;
    meta.broken = broken;
  })
