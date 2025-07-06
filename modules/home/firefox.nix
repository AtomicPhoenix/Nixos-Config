_: {
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        isDefault = true; # Implied by id = 0 but I'm including it anyways
        name = "ai-primary"; # Name listed in about:profiles
        settings = {
          # "browser.startup.homepage" = "https://duckduckgo.com";
          "browser.search.defaultenginename" = "ddg";
          "browser.search.order.1" = "ddg";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        search = {
          force = true;
          default = "ddg";
          order = ["ddg" "google"];
        };
        userChrome = ''
          #tabbrowser-tabs tab.tabbrowser-tab[selected="true"], #tabbrowser-tabs tab.tabbrowser-tab[multiselected="true"] {border-bottom: 2px solid White !important;}
        '';
      };
    };
    policies = {
      BlockAboutConfig = true; # Change through NixOS from now on
      DefaultDownloadDirectory = "~/Downloads";
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      OverrideFirstRunPage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "default-off";

      ExtensionSettings = {
        "ublock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };

      /*
      ---- PREFERENCES ----
      */
      # Check about:config for options.
      # Preferences = {
      #   "toolkit.legacyUserProfileCustomizations.stylesheets" = {
      #     Value = "true";
      #     Status = "locked";
      #   };
      # };
    };
  };
}
