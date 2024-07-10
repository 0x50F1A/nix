{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.anipy-cli = {
    enable = lib.mkEnableOption "Soaffine AniPy-CLI Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.anipy-cli.enable {
    home = {
      # file."${config.xdg.configHome}/anipy-cli/config.yaml".source =
      #   (pkgs.formats.yaml { }).generate "anipy-config"
      #     {
      #       user_files_path = "${config.xdg.dataHome}/anipy-cli";
      #       download_folder_path = "${config.xdg.userDirs.videos}/anipy-cli/download";
      #       seasonals_dl_path = "${config.xdg.userDirs.videos}/anipy-cli/download/seasonals";
      #       providers = {
      #         binge = [ "yugenanime" ];
      #         default = [ "yugenanime" ];
      #         download = [ "yugenanime" ];
      #         history = [ "yugenanime" ];
      #         mal = [ "yugenanime" ];
      #         seasonal = [ "yugenanime" ];
      #       };
      #       provider_urls = { };
      #       player_path = config.programs.mpv.package;
      #       mpv_commandline_options = [ "--keep-open=no" ];
      #       ffmpeg_hls = false;
      #       remux_to = ".mkv";
      #       download_name_format = "{show_name} - {episode_number}";
      #       dc_presence = false;
      #       auto_open_dl_defaultcli = true;
      #       preferred_type = "sub";
      #       skip_season_search = true;
      #     };
      packages = builtins.attrValues {
        inherit (flake.inputs.anipy-cli.packages.${(builtins.currentSystem or pkgs.system)}) default;
      };
    };
  };
}
