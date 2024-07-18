{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.yt-dlp = {
    enable = lib.mkEnableOption "Soaffine Yt-dlp Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.yt-dlp.enable {
    programs = {
      yt-dlp = {
        enable = true;
        settings = {
          embed-thumbnail = true;
          embed-subs = true;
          sub-langs = "en";
          downloader = lib.getExe pkgs.aria2;
          downloader-args = "${lib.getExe pkgs.aria2}: '-c -x 16 -j 16 -s 16'";
        };
      };
    };
  };
}
