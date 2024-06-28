{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.pls = {
    enable = lib.mkEnableOption "Soaffine Pls Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.pls.enable {
    programs = {
      pls = {
        enable = true;
        enableAliases = true;
      };
    };
  };
}
