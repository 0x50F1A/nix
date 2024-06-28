{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.kodi = {
    enable = lib.mkEnableOption "Soaffine Kodi Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.kodi.enable {
    programs = {
      kodi = {
        enable = true;
      };
    };
  };
}
