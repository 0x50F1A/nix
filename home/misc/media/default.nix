{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.misc.media = {
    enable = lib.mkEnableOption "Soaffine Media Miscellaneous Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.misc.media.enable {
    home.packages = builtins.attrValues {
      inherit (pkgs)
        chafa
        ffmpeg-full
        handbrake # Failed on 2024-06-12
        libgen-cli
        ;
    };
  };
}
