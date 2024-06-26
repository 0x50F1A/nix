{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.hyfetch = {
    enable = lib.mkEnableOption "Soaffine Hyfetch Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.hyfetch.enable {
    programs = {
      hyfetch = {
        enable = true;
        settings = {
          preset = "nonbinary";
          mode = "rgb";
          light_dark = "dark";
          lightness = 0.65;
          color_align = {
            mode = "horizontal";
          };
        };
      };
    };
  };
}
