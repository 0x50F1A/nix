{ config, lib, ... }:
let
  # https://github.com/daltonmenezes/aura-theme/blob/main/packages/alacritty/aura-theme.toml
  aura_theme = {
    colors = {
      primary = {
        background = "#15141b";
        foreground = "#edecee";
      };
      normal = {
        black = "#110f18";
        red = "#ff6767";
        green = "#61ffca";
        yellow = "#ffca85";
        blue = "#a277ff";
        magenta = "#a277ff";
        cyan = "#61ffca";
        white = "#edecee";
      };
      bright = {
        black = "#4d4d4d";
        red = "#ff6767";
        green = "#61ffca";
        yellow = "#ffca85";
        blue = "#a277ff";
        magenta = "#a277ff";
        cyan = "#61ffca";
        white = "#edecee";
      };
      selection = {
        text = "CellForeground";
        background = "#29263c";
      };
      cursor = {
        cursor = "#a277ff";
      };
      search = {
        foreground = "#edecee";
        background = "#a277ff";
      };
    };
  };
in
{
  _file = ./default.nix;

  options.sof.alacritty = {
    enable = lib.mkEnableOption "Soaffine Alacritty Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.alacritty.enable {
    programs = {
      alacritty = {
        enable = true;
        settings = {
          bell = {
            animation = "EaseOutQuint";
            duration = 0;
          };
          inherit (aura_theme) colors;
          cursor = {
            style = {
              shape = "Beam";
              blinking = "On";
            };
            vi_mode_style = {
              shape = "Block";
              blinking = "Off";
            };
          };
          font = {
            normal = {
              family = "JetBrains Mono";
              style = "Regular";
            };
            bold = {
              style = "Bold";
            };
            italic = {
              style = "Italic";
            };
          };
          mouse = {
            hide_while_typing = true;
          };
          terminal = {
            osc52 = "Disabled";
          };
          window = {
            opacity = 0.7;
            blur = true;
          };
        };
      };
    };
  };
}
