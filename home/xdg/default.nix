{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.xdg = {
    enable = lib.mkEnableOption "Soaffine XDG Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.xdg.enable {
    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;
        extraConfig = {
          XDG_DEV_DIR = "${config.home.homeDirectory}/Developer";
          XDG_SOURCE_DIR = "${config.home.homeDirectory}/Source";
          XDG_PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
          XDG_WORKSPACES_DIR = "${config.home.homeDirectory}/Workspaces";
        };
      };
      portal = {
        enable = true;
        configPackages = builtins.attrValues {
          inherit (pkgs) xdg-desktop-portal-wlr xdg-desktop-portal-kde xdg-desktop-portal-gtk;
        };
        extraPortals = builtins.attrValues {
          inherit (pkgs) xdg-desktop-portal-wlr xdg-desktop-portal-kde xdg-desktop-portal-gtk;
        };
        xdgOpenUsePortal = true;
      };
    };
  };
}
