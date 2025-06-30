{lib, ...}: {
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
    };

    # Enables DHCP on each ethernet and wireless interface.
    # In case of scripted networking (the default) this is the recommended approach. When using systemd-networkd it's still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;
    # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

    # nat = {
    #   enable = true;
    #   internalInterfaces = ["ens3"];
    #   externalInterface = "wg0";
    #   forwardPorts = [
    #     {
    #       sourcePort = 80;
    #       proto = "tcp";
    #       destination = "10.100.0.3:80";
    #     }
    #   ];
    # };
    # Previous section is equivalent to :
    # nftables = {
    #   enable = true;
    #   ruleset = ''
    #     table ip nat {
    #       chain PREROUTING {
    #         type nat hook prerouting priority dstnat; policy accept;
    #         iifname "ens3" tcp dport 80 dnat to 10.100.0.3:80
    #       }
    #     }
    #   '';
    # };

    # # Open ports in the firewall.
    # firewall.allowedTCPPorts = [22];
    # firewall.allowedUDPPorts = [ ... ];
    # # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };
}
