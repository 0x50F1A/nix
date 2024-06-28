{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.mangohud = {
    enable = lib.mkEnableOption "Soaffine MangoHUD Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.mangohud.enable {
    programs = {
      mangohud = {
        enable = true;
        enableSessionWide = false;
        settingsPerApplication = {
          zed = {
            no_display = true;
          };
        };
      };
    };
  };
}
