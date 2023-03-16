{R, pkgs, util-linux, buildRPackage }:


let
  inherit (pkgs) cacert fetchurl stdenv lib util-linux;


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
