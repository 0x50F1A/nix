{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.gallery-dl = {
    enable = lib.mkEnableOption "Soaffine Gallery-dl Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.gallery-dl.enable {
    programs = {
      gallery-dl = {
        enable = true;
        settings = { };
      };
    };
  };
}
