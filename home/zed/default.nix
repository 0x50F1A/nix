{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.zed = {
    enable = lib.mkEnableOption "Soaffine Zed Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.zed.enable {
    home.packages = builtins.attrValues { inherit (pkgs) treefmt zed-editor; };
    # home.sessionVariables = {
    #   EDITOR = lib.getExe pkgs.helix;
    #   VISUAL = lib.getExe pkgs.zed-editor;
    # };
  };
}
