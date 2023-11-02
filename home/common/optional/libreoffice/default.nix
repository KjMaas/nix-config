{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libreoffice-qt  # Comprehensive, professional-quality productivity suite

    # Dictionaries
    hunspell              # Spell checker
    hunspellDicts.en-us   # Hunspell dictionary for English (United States) from Wordlist
    hunspellDicts.fr-any  # Hunspell dictionary for French (any variant) from Dicollecte
    hunspellDicts.nl_nl   # Hunspell dictionary for Dutch (Netherlands) from OpenTaal

  ];

}
