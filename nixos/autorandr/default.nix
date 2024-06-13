{ config, lib, ... }:
{
  _file = ./default.nix;
  options.sof.autorandr = {
    enable = lib.mkEnableOption "Soaffine Autorandr Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.autorandr.enable {
    services.autorandr = {
      enable = false;
    };
  };
}
