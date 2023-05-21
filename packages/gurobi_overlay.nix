self: super:
rec {
#rPackages is a big function that returns a set of nix packages that happen to be r packages
  #rather than trying to remix rPackges with overlays, I can use nixpkgs.config
  python3 = super.python3.override {
    packageOverrides = self: super: {
      gurobipy = super.gurobipy.overrideAttrs(oldAttrs: {
        version = "10.0.1";
      });
    };
  };

  gurobi = (super.callPackage ./gurobi_latest.nix {python3 = python3;});
}
