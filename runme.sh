nix build
qemu-system-x86_64 \
    -kernel result/bzImage -initrd result/initramfs.cpio.gz \
    -append console=ttyS0 -nographic
