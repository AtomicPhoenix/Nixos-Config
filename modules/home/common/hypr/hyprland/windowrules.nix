_: [
  {
    name = "Firefox PiP";
    "match:initial_class" = "firefox";
    "match:initial_title" = "^Picture.*$";
    pin = "on";
    float = "on";
    size = "(monitor_w*.4) (monitor_h*.4)";
  }
  {
    name = "mpv";
    "match:class" = "mpv";
    pin = "on";
    float = "on";
    size = "(monitor_w*.4) (monitor_h*.4)";
  }
  {
    name = "Discord";
    "match:initial_class" = "discord";
    workspace = "11 silent";
    monitor = 1;
  }
  {
    name = "Spotify";
    "match:initial_class" = "spotify";
    workspace = "12 silent";
    monitor = 1;
  }
  {
    name = "ClickUp";
    "match:initial_class" = "ClickUp";
    workspace = "13 silent";
    monitor = 1;
  }
  {
    name = "Obsidian";
    "match:initial_class" = "obsidian";
    workspace = "14";
    monitor = 1;
  }
  {
    name = "ProtonVPN";
    "match:initial_title" = "Proton VPN";
    size = "(400) (700)";
    center = true;
  }
  {
    name = "All";
    "match:initial_class" = ".*";
    suppress_event = "maximize";
  }
]
