{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.ssh = {
    enable = lib.mkEnableOption "Soaffine SSH Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.ssh.enable {
    programs = {
      ssh = {
        enable = true;
      };
    };
  };
}
