{

  stow_dotfiles_script = origin: ''
    #!/usr/bin/env bash

    # stows config files contained in a module's "dotfiles" directory.
    # The symlinked dotfiles can then be edited manually (they are not
    # located in the read-only /nix/store/... directory)
    # example of the end result:
    # ~/.config/rofi/ -> ~/FLAKE_DIR_HOME_MODULES/origin/dotfiles/rofi/

    echo "stowing config for ${origin}..."
    DIR=$HOME_MANAGER_CONFIG_DIR/${origin}
    TARGET=$HOME/.config
    stow -R -d $DIR dotfiles -t $TARGET -v 1 
    echo "---"
  '';

}
