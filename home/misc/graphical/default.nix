{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.misc.graphical = {
    enable = lib.mkEnableOption "Soaffine Graphical Miscellaneous Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.misc.graphical.enable {
    home.packages = builtins.attrValues { inherit (pkgs) warp-terminal; };
  };
}
