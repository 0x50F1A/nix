{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.mpv = {
    enable = lib.mkEnableOption "Soaffine MPV Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.mpv.enable {
    warnings = lib.optional (config.sof.mpv.enable) ''
      MPV is highly unconfigured, maybe we should use this: https://github.com/Zabooby/mpv-config
    '';
    programs = {
      mpv = {
        enable = true;
        config = lib.mkMerge [ { ytdl-format = "bestvideo+bestaudio"; } ];
      };
    };
  };
}
