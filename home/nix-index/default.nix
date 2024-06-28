{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.nix-index = {
    enable = lib.mkEnableOption "Soaffine Nix-index Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.nix-index.enable {
    programs = {
      nix-index = {
        enable = true;
      };
    };
  };
}
