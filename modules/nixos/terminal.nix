_: {
  environment = {
    # System-wide environment variables; Available to services
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    # User environment variables
    variables = {
      XCURSOR_SIZE = "32";
      EDITOR = "nvim";
      BROWSER = "firefox";
      GRIM_DEFAULT_DIR = "/home/ai/Pictures/";
    };
  };
}
