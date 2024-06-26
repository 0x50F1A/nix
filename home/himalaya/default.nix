{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.himalaya = {
    enable = lib.mkEnableOption "Soaffine Himalaya Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.himalaya.enable {
    programs = {
      himalaya = {
        enable = true;
      };
    };
  };
}
