{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.comodoro = {
    enable = lib.mkEnableOption "Soaffine Comodoro Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.comodoro.enable {
    programs = {
      comodoro = {
        enable = true;
        settings = {
          presets = {
            work = { };
          };
        };
      };
    };
  };
}
