{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.obsidian = {
    enable = lib.mkEnableOption "Soaffine Obsidian Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.obsidian.enable {
    home.packages = builtins.attrValues { inherit (pkgs) obsidian obsidian-export; };
  };
}
