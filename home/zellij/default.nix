{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.zellij = {
    enable = lib.mkEnableOption "Soaffine Zellij Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.zellij.enable {
    programs = {
      zellij = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        settings = {
          on_force_close = "detach";
        };
      };
    };
  };
}
