{
  nix = {

    settings = {

      experimental-features = [ "nix-command" "flakes" "repl-flake" ];

      trusted-users = [ "root" "klaasjan" ];

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

