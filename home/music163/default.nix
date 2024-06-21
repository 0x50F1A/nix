{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.music163 = {
    enable = lib.mkEnableOption "Soaffine music163 Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.music163.enable { home.packages = [ pkgs.yesplaymusic ]; };
}
