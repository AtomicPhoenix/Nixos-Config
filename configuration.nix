# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# configuration.nix
{inputs, pkgs, ...}: 
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "ntfs" ] ;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 10;
  
  # remove nix-channel related tools & configs, we use flakes instead.
  nix.channel.enable = false; 

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Optimize storage
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;    
    wireplumber = {
      enable = true;
      package = pkgs.wireplumber;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ai = {
    isNormalUser = true;
    description = "AI";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    experimental-features = [ "nix-command" "flakes" ];
  };

  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # nixpkgs.overlays = [ programs.hyprland.overlays.default ];

  services.fwupd.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   alacritty
   firefox
   git
   tmux
   spotify
   obsidian
   clickup
   discord
   gh
   feh
   btop
   libgcc
   slurp
   grim
   mako
   libnotify
   wl-clipboard
   fastfetch
   exfatprogs
   alsa-utils
   pavucontrol
   evremap
   waybar
   hyprcursor
   hypridle
   hyprlock
   hyprpaper
   nwg-displays      
   rofi
   chromium
   openssh
 #  wget
  ];
	
  fonts.packages = with pkgs; [
   font-awesome

  ];
hardware.sensor.iio.enable = true;
hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = true;
environment.variables.XCURSOR_SIZE = "32";
environment.variables.EDITOR = "nvim";

systemd.services.dlm.wantedBy = [ "multi-user.target" ];
services.hardware.bolt.enable = true;
services.xserver.videoDrivers = [ "modesetting" ];
services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PasswordAuthentication = true;
    AllowUsers = [ "AI" ]; # Allows all users by default. Can be [ "user1" "user2" ]
    UseDns = true;
    X11Forwarding = false;
    PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
  };
};

# Systemd Services
systemd.services.evremap = {
	wantedBy = [ "multi-user.target" ];
	serviceConfig = {
		ExecStart="/run/current-system/sw/bin/evremap remap /home/ai/.config/evremap.toml -d 0";
		Restart = "always";
		RestartSec = "5";
	};
};

hardware.graphics = {
  enable = true;
  extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];
};

services.keyd = {
  enable = true;
  keyboards = {
    # The name is just the name of the configuration file, it does not really matter
    default = {
      ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
      # Everything but the ID section:
      settings = {
        # The main layer, if you choose to declare it in Nix
        main = {
          capslock = "layer(control)"; # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
        };
        otherlayer = {};
      };
      extraConfig = ''
        # put here any extra-config, e.g. you can copy/paste here directly a configuration, just remove the ids part
      '';
    };
  };
}; 



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
   networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

# let
#   disable-script = pkgs.writeScript ""disable-eDP2.sh"" ''
#     ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-2 --off
#   '';
#   enable-script = pkgs.writeScript ""enable-eDP2.sh"" ''
#     ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-2 --below eDP-1 --auto
#   '';
# in
# {
#   services.udev.extraRules = ''
#     ACTION==""add"",    ATTRS{idVendor}==""0b05"", ATTRS{idProduct}==""1b2c"", ENV{DISPLAY}="":0"", ENV{XAUTHORITY}=""/home/mfenniak/.Xauthority"", RUN+=""${pkgs.bash}/bin/bash ${disable-script}""
#     ACTION==""remove"", ATTRS{idVendor}==""0b05"", ATTRS{idProduct}==""1b2c"", ENV{DISPLAY}="":0"", ENV{XAUTHORITY}=""/home/mfenniak/.Xauthority"", RUN+=""${pkgs.bash}/bin/bash ${enable-script}""
#   '';
# }
}
