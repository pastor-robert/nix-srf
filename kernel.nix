# kernel.nix

{ pkgs ? import <nixpkgs> {} }:

# Build the minimal kernel
pkgs.linux.override {
    structuredConfig = with pkgs.lib.kernel; {
      BLK_DEV_INITRD = yes;
      DEVTMPFS = yes;
      DEVTMPFS_MOUNT = yes;
      BINFMT_ELF = yes;
      SERIAL_8250 = yes;
      SERIAL_8250_CONSOLE = yes;
      TTY = yes;
    };
  }
