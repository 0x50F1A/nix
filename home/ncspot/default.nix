{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.ncspot = {
    enable = lib.mkEnableOption "Soaffine Ncurses Spotify Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.ncspot.enable {
    programs = {
      ncspot = {
        enable = true;
        settings = {
          use_nerdfont = true;
          default_keybindings = true;
          notify = true;
          bitrate = 320;
          gapless = true;
        };
      };
    };
  };
}
