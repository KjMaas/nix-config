{ pkgs, ... }:

{

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # Mount, trash, and other functionalities
  services.gvfs.enable = true;
  # Thumbnail support for images
  services.tumbler.enable = true;

  # extend support tumbler's thumbnails
  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer         # A lightweight video thumbnailer
    poppler                   # A PDF rendering library
    webp-pixbuf-loader        # WebP GDK Pixbuf Loader library
    haskellPackages.freetype2 # Haskell bindings for FreeType 2 library
  ];

}
