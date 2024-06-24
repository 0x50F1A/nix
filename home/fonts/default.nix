{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.fonts = {
    enable = lib.mkEnableOption "Soaffine Fonts Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.fonts.enable {
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          monospace = [ "Noto Color Emoji" ];
          sansSerif = [ "Noto Color Emoji" ];
          serif = [
            "Noto Serif"
            "Noto Color Emoji"
          ];
        };
      };
    };
  };
}
