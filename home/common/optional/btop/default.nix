{

  programs.btop = {
    enable = true;

    extraConfig = ''
      toString ./btop.conf;
    '';

  };

}
