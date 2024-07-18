{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.activitywatch = {
    enable = lib.mkEnableOption "Soaffine ActivityWatch Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.activitywatch.enable {
    services = {
      activitywatch = {
        enable = true;
        watchers = {
          aw-watcher-afk.package = pkgs.activitywatch;
          aw-watcher-window.package = pkgs.activitywatch;
        };
      };
    };

    home.packages = builtins.attrValues { inherit (pkgs) aw-qt aw-watcher-afk aw-watcher-window; };
  };
}
