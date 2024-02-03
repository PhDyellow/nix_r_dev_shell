self: super:
{
#rPackages is a big function that returns a set of nix packages that happen to be r packages
#rather than trying to remix rPackges with overlays, I can use nixpkgs.config
  #gdal = super.gdal.override {poppler = super.poppler_0_61;};
  #
  RmkDerive = (super.callPackage ./rmkderive_flake.nix {buildRPackage = self.buildRPackage;});
  R = super.R.overrideAttrs (_: {enableMemoryProfiling = true;
                                 ## Needed for R to pass checks when compiled
                                 ## with GCC and different BLAS/LAPACK libraries
                                 MKL_THREADING_LAYER="GNU";
                                 MKL_INTERFACE_LAYER="GNU,LP64";
                                });
  rPackages = super.rPackages.override {
    overrides = {
        #
        #
        ##### Newer than nixpkgs CRAN
        #languageserver = (super.callPackage ./languageserver_github.nix {}); #github ahead of nixpkgs
        #bigsgPLS = (super.callPackage ./bigsgPLS.nix {});
        #curveDepthtemp = (super.callPackage ./curveDepthtemp.nix {});
        #sf = (super.callPackage ./sf_github.nix {});
        #    prioritizr = (super.callPackage ./prioritizr_github.nix {});
        #

        ##### Development version has features I need. CRAN will catch up eventually
        #wdpar = (super.callPackage ./wdpar_github.nix {});



        ##### Fixes for nixpkgs
        #exactextractr = (super.callPackage ./exactextractr.nix {}); #missing geos as a build input
        #lwgeom = (super.callPackage ./lwgeom.nix {}); #missing geos as a build input
        #RcppArmadillo = RcppArmadillo_stage1.overrideDerivation (attrs: {
        #  patchPhase = "patchShebangs configure";
        #  PKGCONFIG_CFLAGS = "-I${super.pkgs.openssl.dev}/include -I${super.pkgs.cyrus_sasl.dev}/include -I${super.pkgs.zlib.dev}/include";
        #});
        #rgdal = (super.callPackage ./rgdal.nix {});
        #sf = (super.callPackage ./sf_github.nix {});
        #clustermq = (super.callPackage ./clustermq.nix {}); #up to date on CRAN/nix
        # callr = (super.callPackage ./callr.nix {});
        # lpsymphony = super.rPackages.lpsymphony.overrideDerivation  (attrs:{
        #         nativeBuildInputs = [super.pkgs.pkgconfig
        #                              super.pkgs.gfortran
        #                              super.pkgs.gettext];
        #         preConfigure = ''
        #                 patchShebangs configure
        #                         '';
        # }); #missing pkgconfig

        ##### My packages and lab packages
        phil_rutilities = (super.callPackage ./phil_rutilities.nix {});
        phil_rmethods = (super.callPackage ./phil_rmethods.nix {});
        rphildyerphd = (super.callPackage ./rphildyerphd.nix {});
        castcluster = (super.callPackage ./castcluster.nix {});
        gfbootstrap = (super.callPackage ./gfbootstrap.nix {});
        gradientforest = (super.callPackage ./gradientforest.nix {}); #not in CRAN
        # emmix = (super.callPackage ./emmix.nix {}); #not in CRAN
        VoCC = (super.callPackage ./VoCC.nix {});
        planktonr = (super.callPackage ./planktonr.nix {}); #lab package, not in CRAN yet

        ##### Not in cran, and never will be
        ClimateOperators  = (super.callPackage ./climateoperators.nix {}); #not in CRAN
        mvpart = (super.callPackage ./mvpart_github.nix {}); #not in CRAN
        unigd = (super.callPackage ./unigd_github.nix {}); #not in CRAN
        # gurobi = (super.callPackage ./gurobi.nix {});
        nvimcom = (super.callPackage ./nvimcom.nix {}); #Not in CRAN
    };
  };
}
