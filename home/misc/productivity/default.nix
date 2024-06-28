{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.misc.productivity = {
    enable = lib.mkEnableOption "Soaffine Productivity Miscellaneous Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.misc.productivity.enable {
    home.packages = builtins.attrValues { inherit (pkgs) zotero; };
  };
}
