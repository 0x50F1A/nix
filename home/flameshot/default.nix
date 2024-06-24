{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.flameshot = {
    enable = lib.mkEnableOption "Soaffine Flameshot Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.flameshot.enable {
    home.packages = builtins.attrValues { inherit (pkgs) grim; };
    services = {
      flameshot = {
        enable = true;
        settings = {
          General = {
            savePath = "/home/${flake.config.affineUser.name}/Pictures";
            saveAsFileExtension = ".png";
            uiColor = "#2d0096";
            checkForUpdates = false;
          };
        };
      };
    };
  };
}
