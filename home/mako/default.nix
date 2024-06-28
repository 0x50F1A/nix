{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.mako = {
    enable = lib.mkEnableOption "Soaffine Mako Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.mako.enable {
    services = {
      mako = {
        enable = true;
      };
    };
  };
}
