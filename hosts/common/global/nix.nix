{
  nix = {

    settings = {

      experimental-features = [ "nix-command" "flakes" "repl-flake" ];

      trusted-users = [ "root" "klaasjan" ];

      substituters = [
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      # Replace identical files in the store by hard links
      auto-optimise-store = true;

      # Warn about dirty Git/Mercurial trees.
      warn-dirty = false;

    };

    # Automate Garbage Collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

  };
}

