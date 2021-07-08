self: super:
{
	proj = (super.callPackage ./proj4_v6.nix {}); #this will be merged in to master very soon TODO 2019-07-13
	proj-datumgrid = (super.callPackage ./proj-datumgrid_v6.nix {});
	libspatialite = (super.callPackage ./libspatialite.nix {});
	libgeotiff = (super.callPackage ./libgeotiff.nix {});
	gdal = (super.callPackage ./gdal.nix {});
	
	rPackages = (super.rPackages or {}) // {
		rgdal = (super.callPackage ./rgdal.nix {proj = self.proj; proj-datumgrid = self.proj-datumgrid; gdal = self.gdal;});	
		bigsgPLS = (super.callPackage ./bigsgPLS.nix {});
		curveDepthtemp = (super.callPackage ./curveDepthtemp.nix {});
		#sdmpredictors = (super.callPackage ./sdmpredictors.nix {});
		emmix = (super.callPackage ./emmix.nix {});
		gradientforest = (super.callPackage ./gradientforest.nix {});
		nvimcom = (super.callPackage ./nvimcom.nix {});
	};
		
}