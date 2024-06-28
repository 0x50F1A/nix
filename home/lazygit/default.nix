{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.lazygit = {
    enable = lib.mkEnableOption "Soaffine Lazygit Home Configuration" // {
      default = true;
    };
    followsGitConfiguration = lib.mkEnableOption "following the configuration in git" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.lazygit.enable {
    programs = {
      lazygit = {
        enable = true;
        settings = {
          git = {
            paging = {
              colorArg = "always";
              pager = lib.mkIf (
                !config.sof.lazygit.followsGitConfiguration
              ) "${lib.getExe pkgs.delta} --dark --page=never";
              useConfig = config.sof.lazygit.followsGitConfiguration;
            };
            parseEmoji = true;
          };
          nerdFontsVersion = "3";
          reporting = "off";
          update.method = "never";
        };
      };
    };
  };
}
