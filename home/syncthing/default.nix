{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.syncthing = {
    enable = lib.mkEnableOption "Soaffine Syncthing Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.syncthing.enable {
    services = {
      syncthing = {
        enable = true;
      };
    };
  };
}
