{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.misc.wayland = {
    enable = lib.mkEnableOption "Soaffine Wayland Miscellaneous Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.misc.wayland.enable {
    home.packages = builtins.attrValues { inherit (pkgs) grim slurp wl-clipboard-rs; };
  };
}
