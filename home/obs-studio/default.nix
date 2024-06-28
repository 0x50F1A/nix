{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.obs-studio = {
    enable = lib.mkEnableOption "Soaffine OBS-Studio Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.obs-studio.enable {
    programs = {
      obs-studio = {
        enable = true;
        plugins = builtins.attrValues {
          inherit (pkgs.obs-studio-plugins)
            advanced-scene-switcher
            droidcam-obs
            input-overlay
            obs-backgroundremoval
            obs-command-source
            obs-composite-blur
            obs-gradient-source
            obs-gstreamer
            obs-pipewire-audio-capture
            obs-replay-source
            obs-shaderfilter
            obs-source-clone
            obs-source-switcher
            obs-teleport
            obs-text-pthread
            obs-transition-table
            obs-tuna
            obs-vaapi
            obs-vertical-canvas
            obs-vkcapture
            wlrobs
            ;
        };
      };
    };
  };
}
