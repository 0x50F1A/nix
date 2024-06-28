{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.lsd = {
    enable = lib.mkEnableOption "Soaffine LSD Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.lsd.enable {
    programs = {
      lsd = {
        enable = false;
        enableAliases = true;
        settings = {
          indicators = true;
          sorting = {
            dir-grouping = "first";
          };
          total-size = true;
        };
      };
    };
  };
}
