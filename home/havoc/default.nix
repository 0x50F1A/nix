{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.havoc = {
    enable = lib.mkEnableOption "Soaffine Havoc Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.havoc.enable {
    programs = {
      havoc = {
        enable = true;
      };
    };
  };
}
