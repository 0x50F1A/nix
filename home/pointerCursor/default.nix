{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.pointerCursor = {
    enable = lib.mkEnableOption "Soaffine Graphical Cursors Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.pointerCursor.enable {
    home.pointerCursor = {
      # inherit (config.affineUser.theme.cursor) name package size;
      inherit (config.affineUser.theme.cursor) size;
      x11.enable = true;
      # gtk.enable = true;
    };
  };
}
