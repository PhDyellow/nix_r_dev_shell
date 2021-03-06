{ stdenv, lib, fetchurl, autoPatchelfHook, python }:

let
  majorVersion = "9.1";
in stdenv.mkDerivation rec {
  pname = "gurobi";
  version = "${majorVersion}.2";

  src = with lib; fetchurl {
    url = "http://packages.gurobi.com/${versions.majorMinor version}/gurobi${version}_linux64.tar.gz";
    sha256 = "16s2grp6zs4d5mjvfcxhy93843s73nm35micnfr6nivrbxkvsq3z";
  };

  sourceRoot = "gurobi${builtins.replaceStrings ["."] [""] version}/linux64";

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ (python.withPackages (ps: [ ps.gurobipy ])) ];

  buildPhase = ''
    cd src/build
    make
    cd ../..
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp bin/* $out/bin/
    rm $out/bin/gurobi.sh
    rm $out/bin/python3.7
    cp lib/gurobi.py $out/bin/gurobi.sh
    mkdir -p $out/include
    cp include/gurobi*.h $out/include/
    mkdir -p $out/lib
    cp lib/*.jar $out/lib/
    cp lib/libGurobiJni*.so $out/lib/
    cp lib/libgurobi*.so* $out/lib/
    cp lib/libgurobi*.a $out/lib/
    cp src/build/*.a $out/lib/
    mkdir -p $out/share/java
    ln -s $out/lib/gurobi.jar $out/share/java/
    ln -s $out/lib/gurobi-javadoc.jar $out/share/java/
  '';

  passthru.libSuffix = lib.replaceStrings ["."] [""] majorVersion;

  meta = with lib; {
    description = "Optimization solver for mathematical programming";
    homepage = "https://www.gurobi.com";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ jfrankenau ];
  };
}
