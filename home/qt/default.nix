{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.qt = {
    enable = lib.mkEnableOption "Soaffine QT Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.qt.enable {
    qt = {
      enable = true;
      kde = {
        settings = { };

      };
      platformTheme = {
        name = "kvantum";
      };
      style = {
        name = "kvantum";
      };
    };
  };
}
