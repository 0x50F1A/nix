{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.wezterm = {
    enable = lib.mkEnableOption "Soaffine Wezterm Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.wezterm.enable {
    programs = {
      wezterm = {
        enable = true;
        extraConfig = ''
          local wezterm = require("wezterm")
          local config = wezterm.config_builder()
          config.front_end = 'WebGpu'
          config.enable_wayland = true
          config.hide_tab_bar_if_only_one_tab = true
          config.color_scheme = "Dark Pastel"
          config.window_background_opacity = 0.8
          config.font = wezterm.font_with_fallback {
              'JetBrains Mono',
              'MesloLGS NF',
              'MesloLGS Nerd Font Mono',
              'Fira Code',
              'PowerlineExtraSymbols',
              'Noto Color Emoji',
          }
          config.warn_about_missing_glyphs = false
          config.allow_square_glyphs_to_overflow_width = 'WhenFollowedBySpace'
          config.font_size = ${builtins.toString flake.config.affineUser.theme.terminal.fontSize}
          config.default_cursor_style = 'BlinkingBar'
          return config
        '';
      };
    };
    home.sessionVariables = {
      TERMINAL = "wezterm";
    };
  };
}
