{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.zathura = {
    enable = lib.mkEnableOption "Soaffine Zathura Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.zathura.enable {
    programs = {
      zathura = {
        enable = true;
      };
    };
  };
}
