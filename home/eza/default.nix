{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.eza = {
    enable = lib.mkEnableOption "Soaffine Eza Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.eza.enable {
    programs = {
      eza = {
        enable = false;
        icons = true;
        git = true;
      };
    };
  };
}
