self: super:
{
#rPackages is a big function that returns a set of nix packages that happen to be r packages
#rather than trying to remix rPackges with overlays, I can use nixpkgs.config

  phantomjs2 = (super.callPackage ./phantomjs2.nix {});
}
