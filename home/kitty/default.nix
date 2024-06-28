{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.kitty = {
    enable = lib.mkEnableOption "Soaffine Kitty Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.kitty.enable {
    programs = {
      kitty = {
        enable = true;
        font = {
          name = builtins.elemAt flake.config.affineUser.theme.defaultFonts.monospace 0;
          size = flake.config.affineUser.theme.terminal.fontSize;
        };
        settings = {
          cursor_shape = "beam";
          cursor_shape_unfocused = "hollow";
          detect_urls = true;
          enable_audio_bell = false;
          update_check_interval = 0;
        };
      };
    };
  };
}
