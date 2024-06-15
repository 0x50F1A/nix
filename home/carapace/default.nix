{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.carapace = {
    enable = lib.mkEnableOption "Soaffine Carapace Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.carapace.enable {
    warnings = lib.optional (config.sof.carapace.enable) ''
      How the fuck does carapace work? I dunno...
    '';

    programs = {
      carapace = {
        enable = true;
        enableNushellIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
