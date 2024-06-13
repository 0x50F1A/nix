{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;
  options.sof.greetd = {
    enable = lib.mkEnableOption "Soaffine GreetD Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.greetd.enable {
    services.greetd = {
      enable = true;
      vt = 7;
      settings =
        let
          default_session = {
            command = "${lib.meta.getExe pkgs.greetd.tuigreet}";
            user = flake.config.people.myself;
          };
        in
        {
          inherit default_session;
          initial_session = default_session;
        };
    };
  };
}
