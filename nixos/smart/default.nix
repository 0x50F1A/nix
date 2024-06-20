{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.smart = {
    enable = lib.mkEnableOption "Soaffine SMART Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.smart.enable {
    services.smartd = {
      enable = true;
      autodetect = true;
    };

    services.udev.extraRules = ''
      SUBSYSTEM=="nvme", KERNEL=="nvme[0-9]*", GROUP="disk"
    '';
  };
}
