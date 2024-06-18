{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.direnv = {
    enable = lib.mkEnableOption "Soaffine Direnv Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.direnv.enable {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
        config = {
          global.warn_timeout = "60s";
        };
      };
    };
  };
}
