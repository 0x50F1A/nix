{pkgs, ...}: let
  toInstall = builtins.attrValues {inherit (pkgs) river sway;};
in {
  environment.systemPackages = toInstall;
  services.displayManager.sessionPackages = toInstall;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
