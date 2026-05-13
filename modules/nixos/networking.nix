{lib, ...}: {
  services.resolved.enable = true;
  networking = {
    # Enable firewall
    firewall = {
      checkReversePath = false;
      enable = true;
      allowedTCPPorts = [80];
    };

    # Enable networking
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    # Enables DHCP on each ethernet and wireless interface.
    useDHCP = lib.mkDefault true;
  };
}
