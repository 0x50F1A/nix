{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.command-not-found = {
    enable = lib.mkEnableOption "Soaffine Command Not Found Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.command-not-found.enable {
    programs = {
      command-not-found = {
        enable = (!config.sof.nix-index.enable);
      };
    };
  };
}
