final: prev:
{
  # virtualised hosts don't work with `-cpu max`
  # vmTools = prev.vmTools.override (oldAttrs: rec {
  #   qemu-common = import ./qemu_common_patched.nix {lib = final.lib; pkgs = final.pkgs;};
  # });
  # vmTools = (prev.vmTools or {}) // {qemu-common = (import ./qemu_common_patched.nix) { lib = final.lib; pkgs = final.pkgs;};};
  #vmTools.qemu-common = import ./qemu_common_patched.nix {lib = self.lib; pkgs = self.pkgs;};
  vmTools = prev.makeOverridable (import ./vmTools_patched.nix) { pkgs = final.pkgs; lib = final.lib; };
}
