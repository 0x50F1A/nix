{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.swaylock = {
    enable = lib.mkEnableOption "Soaffine Swaylock Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.swaylock.enable {
    programs = {
      swaylock = {
        enable = true;
        settings = {
          color = "808080";
          font-size = 24;
          indicator-idle-visible = true;
          indicator-radius = 100;
          line-color = "ffffff";
        };
      };
    };
  };
}
