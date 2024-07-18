{
  config,
  flake,
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
        handbrake
        libgen-cli
        ;
      inherit (flake.inputs.anipy-cli.packages.${(builtins.currentSystem or pkgs.system)}) default;
      inherit (flake.inputs.lobster.packages.${(builtins.currentSystem or pkgs.system)}) lobster;
    };
  };
}
