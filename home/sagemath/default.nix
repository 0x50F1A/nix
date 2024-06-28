{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.sagemath = {
    enable = lib.mkEnableOption "Soaffine Sagemath Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.sagemath.enable {
    programs = {
      sagemath = {
        enable = true;
      };
    };
  };
}
