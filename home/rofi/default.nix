{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.rofi = {
    enable = lib.mkEnableOption "Soaffine Rofi Bitwarden CLI Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.rofi.enable {
    programs = {
      rofi = {
        enable = true;
        package = pkgs.rofi-wayland.override {
          plugins = builtins.attrValues {
            inherit (pkgs)
              pinentry-rofi
              rofi-calc
              rofi-emoji
              rofi-obsidian
              rofi-rbw-wayland
              rofi-systemd
              ;
          };
        };
        font = builtins.elemAt flake.config.affineUser.theme.defaultFonts.monospace 0;
        plugins = builtins.attrValues {
          inherit (pkgs)
            pinentry-rofi
            rofi-calc
            rofi-emoji
            rofi-obsidian
            rofi-rbw-wayland
            rofi-systemd
            ;
        };
      };
    };
  };
}
