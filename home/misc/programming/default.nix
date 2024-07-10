{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.misc.programming = {
    enable = lib.mkEnableOption "Soaffine Programming Miscellaneous Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.misc.programming.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs)
        fx
        htmlq
        serverless
        tidy-viewer
        xsv
        ;
      inherit (pkgs.python3Packages) yq;
    };
  };
}
