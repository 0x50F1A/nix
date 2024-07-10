{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.topgrade = {
    enable = lib.mkEnableOption "Soaffine Topgrade Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.topgrade.enable {
    programs = {
      topgrade = {
        enable = true;
        settings = {
          misc = {
            assume_yes = true;
            cleanup = true;
            notify_each_step = true;
            run_in_tmux = true;
          };
        };
      };
    };
  };
}
