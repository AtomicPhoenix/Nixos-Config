_: {
  services.keyd = {
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
}
