{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes"; # also needed to deploy on localhost with nixops
    };
  };
}

