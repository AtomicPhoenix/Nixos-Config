_: {
  networking.firewall.allowedTCPPorts = [8102];

  services.openssh = {
    enable = true;
    ports = [8102];
    settings = {
      AllowUsers = ["ai"];
      UseDns = true;
      X11Forwarding = false;
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
