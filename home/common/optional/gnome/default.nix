{ pkgs, ... }:

let
  terminal = "${pkgs.kitty}/bin/kitty";

  # ToFix: this doesn't work! The default terminal is not set to 'kitty'
  # Issue: 'Unable to find terminal required for application' when opening a file in Thunar
  # run `$ set-terminal` to execute the following script:
  set-terminal = pkgs.writeTextFile {
    name = "set-terminal";
    destination = "/bin/set-terminal";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.default-applications.terminal
      gsettings set $gnome_schema exec "${terminal}"
      gsettings set $gnome_schema exec-arg ""
    '';
  };

in
{

  home.packages = with pkgs; [
    set-terminal
    dconf2nix                 # Convert dconf files to Nix, as expected by Home Manager
    gnome.dconf-editor        # GSettings editor for GNOME
    glib                      # C library of programming buildings blocks
    gsettings-desktop-schemas # Collection of GSettings schemas for settings shared by various components of a desktop
  ];

  # dconf.settings = {
  #   "org.gnome.desktop.default-applications.terminal" = {
  #     exec = "kitty";
  #     exec-args = "-x";
  #   };
  # };

}
