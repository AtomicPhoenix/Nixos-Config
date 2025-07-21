{pkgs, ...}: {
  home.packages = with pkgs; [
    protonup # Proton (For running games on Linux)
  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/ai/.steam/root/compatibilitytools.d";
  };
}
