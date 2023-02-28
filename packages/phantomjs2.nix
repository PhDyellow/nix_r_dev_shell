#PhantomJS is not in a good state:
#PhantomJS itself is full of security vulnerabilities.
#On top of that, qtwebkit is also full of security vulnerabilities, and both have been dropped from nixos
#Just downloading binary, and only ever run in a sandbox
{ lib, stdenv,fontconfig, autoPatchelfHook}:


stdenv.mkDerivation rec {
  pname = "phantomjs";
  version = "2.1.1";

  src = fetchTarball {
    url = "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2";
    sha256 = "sha256:0g2dqjzr2daz6rkd6shj6rrlw55z4167vqh7bxadl8jl6jk7zbfv";
  };
  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [fontconfig
                 stdenv.cc.cc.lib
                ];

  installPhase = ''
    mkdir -p $out/bin
    cp bin/phantomjs $out/bin
  '';

  meta = with lib; {
    description = "Headless WebKit with JavaScript API";
    longDescription = ''
      PhantomJS2 is a headless WebKit with JavaScript API.
      It has fast and native support for various web standards:
      DOM handling, CSS selector, JSON, Canvas, and SVG.

      PhantomJS is an optimal solution for:
      - Headless Website Testing
      - Screen Capture
      - Page Automation
      - Network Monitoring
    '';

    homepage = "https://phantomjs.org/";
    license = licenses.bsd3;

    maintainers = [ maintainers.aflatter ];
    platforms = platforms.darwin ++ platforms.linux;
  };
}
