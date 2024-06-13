{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.xserver = {
    enable = lib.mkEnableOption "Soaffine X11 Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.xserver.enable {
    services.xserver = {
      enable = true;
      xkb.layout = "us";
      #    xkbVariant = "colemak_dh";
    };
  };
}
