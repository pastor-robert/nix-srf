# rootfs.nix

{ pkgs ? import <nixpkgs> {} }:

pkgs.runCommand "static-rootfs" { } ''
    mkdir -p $out/bin

    # Copy the static busybox binary
    cp ${pkgs.pkgsStatic.busybox}/bin/busybox $out/bin/busybox
    
    # Create your custom init
    cat <<'EOF' > $out/init
    #!/bin/busybox sh
    export PATH=/bin
    
    /bin/busybox --install
    
    mkdir -p /proc /sys /dev
    mount -t proc proc /proc
    mount -t sysfs sysfs /sys
    mount -t devtmpfs devtmpfs /dev
    
    echo "Static Nix-built rootfs booted!"
    exec /bin/sh
    EOF

    chmod +x $out/init
''

