{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.tealdeer = {
    enable = lib.mkEnableOption "Soaffine Tealdeer Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.tealdeer.enable {
    programs.tealdeer = {
      enable = true;
      settings = {
        cache_dir = "${config.xdg.configHome}/tealdeer";
        display = {
          compact = false;
          use_pager = false;
        };

        updates = {
          auto_update = true;
          auto_update_interval_hours = 168;
        };
      };
    };

    home.activation.ensureTealdeerCacheDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "${config.programs.tealdeer.settings.cache_dir}"
    '';
  };
}
