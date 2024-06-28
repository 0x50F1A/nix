{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.yazi = {
    enable = lib.mkEnableOption "Soaffine Yazi Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.yazi.enable {
    programs = {
      yazi = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableNushellIntegration = true;
        enableZshIntegration = true;
      };
    };

    home.sessionVariables.FILE_BROWSER = lib.getExe pkgs.yazi;
  };
}
