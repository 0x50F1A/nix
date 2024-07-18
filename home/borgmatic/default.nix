{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.borgmatic = {
    enable = lib.mkEnableOption "Soaffine Borgmatic Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.borgmatic.enable {
    services = {
      borgmatic = {
        enable = true;
      };
    };
  };
}
