# runme.nix
{ pkgs ? import <nixpkgs> {} }:

let
  initramfs = import ./initramfs.nix { inherit pkgs; };
  kernel = import ./kernel.nix { inherit pkgs; };
in pkgs.runCommand "kernel-and-initrd" {} ''
  mkdir -p $out
  cp ${initramfs}/* $out/.
  cp ${kernel}/* $out/.
''
