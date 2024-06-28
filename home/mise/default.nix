{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.mise = {
    enable = lib.mkEnableOption "Soaffine Mise Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.mise.enable {
    programs = {
      mise = {
        enable = true;
      };
    };
  };
}
