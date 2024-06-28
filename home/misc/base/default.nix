{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.misc.base = {
    enable = lib.mkEnableOption "Soaffine Base Miscellaneous Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.misc.base.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs)
        file
        mediainfo
        moreutils
        nix-output-monitor
        pigz
        unzip
        ;
    };
  };
}
