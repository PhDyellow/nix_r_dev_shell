import (builtins.fetchGit {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2021-05-04";
  # url = https://github.com/nixos/nixpkgs-channels/;
  url = https://github.com/NixOS/nixpkgs/;
  #  url = https://github.com/PhDyellow/nixpkgs/;
  # Commit hash for nixos-unstable as of 2020-01-20
  # `git ls-remote https://github.com/nixos/nixpkgs-channels nixos-unstable`
  # ref = "refs/heads/master"; #using bleeding edge packages
  # # rev = "e1fc1a80a071c90ab65fb6eafae5520579163783"; # good
  # rev = "988da51d9c49a1d43fe28a5f92394f5dbc16eede"; #bad
  ref = "refs/heads/r-updates"; #using bleeding edge packages

  rev = "b1d8a801a0ae8de0a292e1cdd5fc91e8255b47f7";



})

    { #the attributes to import
      overlays = [
        (import ./packages/rpackages_overlay.nix)
        (import ./packages/gurobi_overlay.nix)
        #(import ./packages/intel_mkl_overlay.nix)
        #(import ./packages/qemu_overlay.nix)
      ];
    }
