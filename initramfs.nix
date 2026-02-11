# initramfs.nix

{ pkgs ? import <nixpkgs> {} }:
let
  staticRootfs = import ./rootfs.nix { inherit pkgs; };
in pkgs.runCommand "initramfs.cpio.gzip" {
  nativeBuildInputs = [ pkgs.cpio pkgs.gzip ];
} ''
  mkdir $out
  cd ${staticRootfs}
  find . -print0 | cpio --null -ov --format=newc | gzip -9 > $out/initramfs.cpio.gz
''
