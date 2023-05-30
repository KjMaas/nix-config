{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "yes"; # also needed to deploy on localhost with nixops
  };
}

