{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.ion = {
    enable = lib.mkEnableOption "Soaffine Ion Shell Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.ion.enable {
    programs = {
      ion = {
        enable = true;
      };
    };
  };
}
