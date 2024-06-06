{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      chafa
      ffmpeg-full
      handbrake
      nuclear
      libgen-cli
      syncplay
      ;
  };
}
