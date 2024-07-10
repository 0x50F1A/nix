{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.tmux = {
    enable = lib.mkEnableOption "Soaffine Tmux Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.tmux.enable {
    programs = {
      tmux = {
        enable = true;
      };
    };
  };
}
