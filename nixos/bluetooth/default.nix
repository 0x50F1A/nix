{ config, lib, ... }:
{
  _file = ./default.nix;
  options.sof.bluetooth = {
    enable = lib.mkEnableOption "Soaffine Bluetooth Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
    };
  };
}
