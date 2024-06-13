{
  config,
  lib,
  pkgs,
  ...
}:
let
  toInstall = builtins.attrValues { inherit (pkgs) river sway; };
in
{
  _file = ./default.nix;

  options.sof.wayland = {
    enable = lib.mkEnableOption "Soaffine Wayland Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.wayland.enable {
    environment.systemPackages = toInstall;
    services.displayManager.sessionPackages = toInstall;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    xdg = {
      portal = {
        enable = true;
        extraPortals = builtins.attrValues {
          inherit (pkgs) xdg-desktop-portal-wlr xdg-desktop-portal-kde xdg-desktop-portal-gtk;
        };
        wlr = {
          enable = true;
        };
        xdgOpenUsePortal = true;
      };
    };
  };
}
