{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.noti = {
    enable = lib.mkEnableOption "Soaffine Noti Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.noti.enable {
    programs = {
      noti = {
        enable = true;
      };
    };
  };
}
