{pkgs, ...}: {
  # RealtimeKit: A D-Bus system service that enables user processes to request realtime scheduling priority (for pipewire).
  security.rtkit.enable = true;

  # PulseAudio sound server
  services.pulseaudio.enable = false; # Use Pipewire, the modern sound subsystem

  # PipeWire
  services.pipewire = {
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

  environment.systemPackages = with pkgs; [
    pulseaudio
    alsa-utils
    pavucontrol # PulseAudio Volume Control
    pamixer # Command-line mixer for PulseAudio
    bluez # Bluetooth support
    bluez-tools # Bluetooth tools
  ];
}
