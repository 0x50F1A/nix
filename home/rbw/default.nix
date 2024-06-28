{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.rbw = {
    enable = lib.mkEnableOption "Soaffine Rust Bitwarden CLI Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.rbw.enable {
    programs = {
      rbw = {
        enable = true;
        settings = {
          email = flake.config.affineUser.email;
          pinentry =
            if config.services.gpg-agent.enable then
              config.services.gpg-agent.pinentryPackage
            else
              pkgs.pinentry-curses;
        };
      };
    };
  };
}
