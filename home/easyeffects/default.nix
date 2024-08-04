{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.easyeffects = {
    enable = lib.mkEnableOption "Soaffine Easy Effects Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.easyeffects.enable {
    warnings = lib.optional (config.sof.firefox.enable) ''
      EasyEffects did not build as of 07-30.
    '';
    services = {
      easyeffects = {
        enable = true;
      };
    };
  };
}
