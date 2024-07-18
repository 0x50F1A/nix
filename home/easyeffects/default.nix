{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.easyeffects = {
    enable = lib.mkEnableOption "Soaffine Easy Effects Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.easyeffects.enable {
    services = {
      easyeffects = {
        enable = true;
      };
    };
  };
}
