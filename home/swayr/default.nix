{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.swayr = {
    enable = lib.mkEnableOption "Soaffine Swayr Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.swayr.enable {
    programs = {
      swayr = {
        enable = true;
        systemd = {
          enable = true;
        };
      };
    };
  };
}
