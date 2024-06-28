{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.kakoune = {
    enable = lib.mkEnableOption "Soaffine Kakoune Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.kakoune.enable {
    programs = {
      kakoune = {
        enable = true;
      };
    };
  };
}
