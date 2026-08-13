{ pkgs, ... }:

{

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
  ];

  # for more info on nix-ld, check
  # https://blog.thalheim.io/2022/12/31/nix-ld-a-clean-solution-for-issues-with-pre-compiled-executables-on-nixos/
  programs.nix-ld = {
    enable = true;

    # Sets up all the libraries to load
    libraries = with pkgs; [
      libxcrypt # libcrypt.so.2
      libxcrypt-legacy # libcrypt.so.1

      # Todo: map the libraries to the import error they solve
      stdenv.cc.cc.lib
      libxkbcommon
      libX11
      libXrender
      libXxf86vm
      libXfixes
      libXi
      libSM
      libICE
      zlib
      glibc
      fuse3
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      curl
      dbus
      expat
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gtk3
      libGL
      libappindicator-gtk3
      libdrm
      libnotify
      libpulseaudio
      libuuid
      libusb1
      libxcb
      mesa
      nspr
      nss
      pango
      pipewire
      systemd
      icu
      openssl

      libXScrnSaver
      libXcomposite
      libXcursor
      libXdamage
      libXext
      libXrandr
      libXtst
      libxkbfile
      libxshmfence
    ];
  };

}
