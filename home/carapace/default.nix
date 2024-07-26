{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.carapace = {
    enable = lib.mkEnableOption "Soaffine Carapace Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.carapace.enable {
    programs = {
      carapace = {
        enable = true;
        enableBashIntegration = true;
        enableNushellIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
