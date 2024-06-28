{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.eza = {
    enable = lib.mkEnableOption "Soaffine Eza Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.eza.enable {
    programs = {
      eza = {
        enable = true;
        icons = true;
        git = true;
      };
    };
  };
}
