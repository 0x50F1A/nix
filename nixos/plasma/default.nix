{
  config,
  lib,
  flake,
  ...
}:
{
  _file = ./default.nix;
  options.sof.plasma = {
    enable = lib.mkEnableOption "Soaffine Plasma Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.plasma.enable {
    services = {
      displayManager = {
        sddm = {
          enable = true;
          enableHidpi = true;
          settings = {
            Autologin = {
              Session = "plasma.desktop";
              User = flake.config.affineUser.name;
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
  };
}
