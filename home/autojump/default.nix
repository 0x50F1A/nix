{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.autojump = {
    enable = lib.mkEnableOption "Soaffine Autojump Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.autojump.enable {
    programs = {
      autojump = {
        enable = true;
      };
    };
  };
}
