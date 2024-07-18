{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.zoxide = {
    enable = lib.mkEnableOption "Soaffine Zoxide Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.zoxide.enable {
    programs = {
      zoxide = {
        enable = true;
      };
    };
  };
}
