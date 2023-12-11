{pkgs}:
let
  rpackages = (import ./r_packages.nix { pkgs = pkgs; });
  python-tensorflow = (pkgs.python3.withPackages(ps: with ps; [tensorflow]));
in
with pkgs;[
          #(stdenv.mkDerivation{
          #  name = "${R.name}-no-save";
          #  inherit (rWrapper.override {
          #      packages = [
          #      ] ++ rpackageslist;
          #    }) meta;
          #  nativeBuildInputs = [ makeWrapper ];
          #  buildCommand = ''
          #    mkdir -p $out/bin
          #    for item in ${R}/bin/*; do
          #      ln -s $item $out/bin/
          #    done
          #    wrapProgram $out/bin/R --add-flags "--no-save"
          #'';})

          # clang
          # rustc
          # cargo
          binutils
          coreutils
          util-linux
          inetutils

          pandoc #needed for rMarkdown

          cairo #for httpdg package

          #gnutar
          #gzip
          #gnumake
          #gcc
          #gawk
          #gnused
          #glibc
          #glibcLocales

          which #explicity include which that R compiled against, rather than fall back to system `which``, for some reason the Rshell which and system which are not identical

          _7zz # used by shell scripts to minimise small files on HPC filesystems

          #needs a shell in the container
          # bashInteractive
          # bash_5

          # gurobi

          ## Functions to work with climate data
          cdo
          # nco

          curl
          wget
          openssh
          openssl
          iputils
          cacert

          phantomjs2 ## hack for wdman, needed by wdpar. Dropped wdpar because nix no longer supports phantomjs
          #also hack for wdman, should pull in selenium
          selenium-server-standalone
          chromedriver
          htmlunit-driver

          # (pkgs.callPackage ./nix_r_compact_libs.nix {rPa = rpackages;
          #                                             R = pkgs.R.override{
          #                                             enableMemoryProfiling = true;
          #                                             };})

          # python-tensorflow

          (radianWrapper.override{
            packages = [
            ] ++ rpackages;
            wrapR = true;
          })

          
          (rstudioWrapper.override {
          packages = [
          ] ++ rpackages;
            })

          (vscode-with-extensions.override {
            vscode = vscodium;
            vscodeExtensions = with vscode-extensions; [
            ]
              ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
              {
               name = "r";
                publisher = "REditorSupport";
                version = "2.7.2";
                sha256 = "sha256-D400Z6OvcGHUxxYKjny+bvV/EcSPQ9PeKUUvYfEOBcE=";
              }
            ];
          })
    ]
