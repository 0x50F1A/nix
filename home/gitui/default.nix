{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.gitui = {
    enable = lib.mkEnableOption "Soaffine Gitui Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.gitui.enable {
    programs = {
      gitui = {
        enable = true;
      };
    };
  };
}
