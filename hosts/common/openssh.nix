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

  users.users.ai.openssh.authorizedKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHMD7R3C50biFqJaBhIXYQZNCKtsM/e35Oh7b1h6ESSX ai@ai-duo"
  ];
}
