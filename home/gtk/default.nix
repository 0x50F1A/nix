{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.gtk = {
    enable = lib.mkEnableOption "Soaffine GTK Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.gtk.enable {
    gtk = {
      cursorTheme = {
        inherit (config.affineUser.theme.cursor) name package size;
      };
      theme = {
        name = "Dracula";
        package = pkgs.dracula-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      font = {
        name = "JetBrains Mono Medium";
        package = pkgs.jetbrains-mono;
        size = 12;
      };
    };
  };
}
