{ pkgs, ...}:
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
      libxcrypt         # libcrypt.so.2
      libxcrypt-legacy  # libcrypt.so.1
      
      # Todo: map the libraries to the import error they solve
      stdenv.cc.cc.lib
      libxkbcommon
      xorg.libX11
      xorg.libXrender
      xorg.libXxf86vm
      xorg.libXfixes
      xorg.libXi
      xorg.libSM
      xorg.libICE
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
      xorg.libxcb
      mesa
      nspr
      nss
      pango
      pipewire
      systemd
      icu
      openssl

      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXrandr
      xorg.libXtst
      xorg.libxkbfile
      xorg.libxshmfence
    ];
  };

}
