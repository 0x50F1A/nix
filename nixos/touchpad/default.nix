{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.touchpad = {
    enable = lib.mkEnableOption "Soaffine Touchpad Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.touchpad.enable {
    services.libinput = {
      enable = true;
      mouse.naturalScrolling = true;
      touchpad.naturalScrolling = true;
      touchpad.tapping = true;
    };
    environment.systemPackages = [ pkgs.libinput ];
  };
}
