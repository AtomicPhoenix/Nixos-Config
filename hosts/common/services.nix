_: let
  keyd = {
    enable = true;
    keyboards = {
      # Name of the configuration file; Arbitrary
      keyd = {
        # Select all keyboards
        ids = ["*"];
        # Everything but the ID section:
        settings = {
          # The main layer
          main = {
            # Maps capslock to escape when pressed and control when held.
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };
  openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = false;
      # Allows all users by default. Can be [ "user1" "user2" ]
      AllowUsers = ["ai"];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
    };
  };
  audio = {
    # RealtimeKit: A D-Bus system service that enables user processes to request realtime scheduling priority (for pipewire).
    security.rtkit.enable = true;

    # PulseAudio sound server
    pulseaudio.enable = false;

    # PipeWire
    pipewire = {
      enable = true;
      # Enable Advanced Linux Sound Architecture (ALSA): A software framework / kernel module providing an API for sound card device drivers.
      alsa = {
        enable = true;
        support32Bit = true;
      };
      # Enable JACK audio emulation.
      jack.enable = true;
      # PulseAudio server emulation.
      pulse.enable = true;
      # WirePlumber is a modular session / policy manager for PipeWire
      wireplumber.enable = true;
    };
  };
  # Firmware updater for Linux
  fwupd.enable = true;
in {
  inherit (audio) security;
  services = {
    inherit keyd openssh fwupd;
    inherit (audio) pulseaudio pipewire;
  };
}
