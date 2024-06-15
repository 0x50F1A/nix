{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.atuin = {
    enable = lib.mkEnableOption "Soaffine Atuin Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.atuin.enable {
    warnings = lib.optional (config.sof.atuin.enable) ''
      Atuin key has not yet been SOPS encrypted.
    '';

    programs = {
      atuin = {
        enable = true;
        settings = {
          daemon = {
            enabled = true;
            socket_path = "/run/user/1000/atuin.socket";
            sync_frequency = 30;
          };
          dotfiles = {
            enabled = true;
          };
          sync = {
            records = true;
          };
          auto_sync = true;
          filter_mode = "session";
          # key_path = "/home/soaffine/.config/atuin/keys/atuin.key"; #SOPS ME
          show_preview = true;
          sync_frequency = 0;
          update_check = false;
          workspaces = true;
        };
      };
    };

    systemd.user.services.atuin-daemon = {
      Unit = {
        Description = "atuin shell history daemon";
      };
      Service = {
        ExecStart = "${lib.getExe pkgs.atuin} daemon";
        Environment = [ "ATUIN_LOG=info" ];
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
