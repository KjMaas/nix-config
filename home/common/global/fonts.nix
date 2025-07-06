{ pkgs, ... }:

{

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    noto-fonts # Beautiful and free fonts for many languages
    noto-fonts-emoji # Color and Black-and-White emoji fonts
    noto-fonts-cjk-sans # Beautiful and free fonts for CJK languages

    fira # Sans-serif font for Firefox OS
    fira-code # Monospace font with programming ligatures
    fira-code-symbols # FiraCode unicode ligature glyphs in private use area

    nerd-fonts.fira-code # Nerd Fonts: Programming ligatures, extension of Fira Mono font, enlarged operators
    nerd-fonts.fira-mono # Nerd Fonts: Mozilla typeface, dotted zero
    nerd-fonts.droid-sans-mono # Nerd Fonts: Good for small screens or font sizes
  ];

}
