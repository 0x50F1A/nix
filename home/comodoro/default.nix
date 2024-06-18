{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.comodoro = {
    enable = lib.mkEnableOption "Soaffine Comodoro Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.comodoro.enable {
    programs =
      let
        notify = desc: "${lib.getExe pkgs.libnotify} '🍅 Comodoro' '${desc}'";
      in
      {
        comodoro = {
          enable = true;
          settings = {
            work = {
              cycles = [
                {
                  name = "Work";
                  duration = 112 * 60;
                }
                {
                  name = "Rest";
                  duration = 26 * 60;
                }
              ];

              tcp-host = "localhost";
              tcp-port = 9999;

              on-work-begin = notify "Work Cycle Begins";
              on-rest-begin = notify "Rest Cycle Begins";
            };
          };
        };
      };

    services = {
      comodoro = {
        enable = true;
        preset = "work";
        protocols = [ "tcp" ];
        environment = {
          RUST_LOG = "debug";
        };
      };
    };
  };
}
