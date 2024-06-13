{ config, lib, ... }:
{
  _file = ./default.nix;
  options.sof.atop = {
    enable = lib.mkEnableOption "Soaffine Atop Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.atop.enable {
    programs.atop = {
      enable = false;
      netatop.enable = true;
      setuidWrapper.enable = true;
      atopService.enable = true;
      atopRotateTimer.enable = true;
    };
  };
}
