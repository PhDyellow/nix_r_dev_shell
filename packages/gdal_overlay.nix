self: super:
{
	libspatialite = (super.callPackage ./libspatialite.nix {});
	libgeotiff = (super.callPackage ./libgeotiff.nix {});
	gdal = (super.callPackage ./gdal.nix {});
}