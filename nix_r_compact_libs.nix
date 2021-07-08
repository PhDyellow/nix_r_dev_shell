{
  pkgs,
  R,
  makeWrapper,
  rPa,
  stdenv,
  util-linux
}:

#takes a list of rPackages, and copies each into it's own out
let

  in stdenv.mkDerivation{

    name = R.name + "-wrapper-compact-lib";

    buildInputs = [makeWrapper R] ++ rPa;

    unpackPhase = ":";

    installPhase = ''
               mkdir -p $out/library
while IFS=':' read -r -a RP; do
  for rpp in ''${RP[@]}; do
    for dir in $rpp/*/; do
      ln -sr $dir $out/library/
    done
  done
done <<< $R_LIBS_SITE
mkdir -p $out/bin
cd ${R}/bin
for exe in *;do
makeWrapper ${R}/bin/$exe $out/bin/$exe \
  --set "R_LIBS_SITE" "$out/library"
done
'';

}
