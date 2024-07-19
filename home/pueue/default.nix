{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.pueue = {
    enable = lib.mkEnableOption "Soaffine Pueue Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.pueue.enable {
    services = {
      pueue = {
        enable = true;
      };
    };
  };
}
