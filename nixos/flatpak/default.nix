{ config, lib, ... }:
{
  _file = ./default.nix;
  options.sof.flatpak = {
    enable = lib.mkEnableOption "Soaffine Flatpak Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.flatpak.enable {
    services.flatpak.enable = true;
    xdg.portal.enable = true;
  };
}
