{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.ripgrep = {
    enable = lib.mkEnableOption "Soaffine Ripgrep Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.ripgrep.enable {
    programs = {
      ripgrep = {
        enable = true;
        arguments = [
          "--count"
          "--smart-case"
          "--max-columns-preview"
          "--colors=line:style:bold"
        ];
      };
    };

    home.packages = builtins.attrValues { inherit (pkgs) vgrep; };
  };
}
