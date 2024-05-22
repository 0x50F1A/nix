_: {
  services = {
    displayManager = {
      sddm = {
        enable = true;
        enableHidpi = true;
        settings = {
          Autologin = {
            Session = "plasma.desktop";
            User = "bryn";
          };
        };
        wayland = {
          enable = true;
        };
      };
    };
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
  };

  programs = {
    kdeconnect.enable = true;
    dconf.enable = true;
  };
}
