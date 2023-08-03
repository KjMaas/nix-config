{ pkgs, ...}:

{

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [

    noto-fonts        # Beautiful and free fonts for many languages
    noto-fonts-emoji  # Color and Black-and-White emoji fonts
    noto-fonts-cjk-sans # Beautiful and free fonts for CJK languages

    fira              # Sans-serif font for Firefox OS
    fira-code         # Monospace font with programming ligatures
    fira-code-symbols # FiraCode unicode ligature glyphs in private use area

    (nerdfonts.override { fonts = [
      "FiraCode"
      "DroidSansMono"
    ]; })

  ];

}
