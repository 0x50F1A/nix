{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.spotify-player = {
    enable = lib.mkEnableOption "Soaffine Spotify-Player Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.spotify-player.enable {
    programs = {
      spotify-player = {
        enable = true;
        settings = {
          theme = "default";
          playback_window_position = "Top";
          copy_command = {
            command = "wl-copy";
            args = [ ];
          };
          device = {
            audio_cache = true;
            normalization = true;
          };
        };
      };
    };
  };
}
