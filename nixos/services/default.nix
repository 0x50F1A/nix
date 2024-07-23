{ config, lib, ... }:
{
  _file = ./default.nix;
  options.sof.services = {
    enable = lib.mkEnableOption "Soaffine Service Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.services.enable {
    services = {
      fail2ban = {
        enable = true;
      };
      fstrim = {
        enable = true;
      };
      fwupd = {
        enable = true;
      };
      ntpd-rs = {
        enable = true;
      };
    };
  };
}
