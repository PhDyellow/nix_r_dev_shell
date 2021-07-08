self: super:
{
	proj = (super.callPackage ./proj4_v6.nix {}); #this will be merged in to master very soon TODO 2019-07-13
	proj-datumgrid = (super.callPackage ./proj-datumgrid_v6.nix {});
}