{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.dircolors = {
    enable = lib.mkEnableOption "Soaffine Dircolors Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.dircolors.enable {
    programs = {
      dircolors = {
        enable = true;
      };
    };
  };
}
