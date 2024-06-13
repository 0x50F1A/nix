{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      chafa
      ffmpeg-full
      # handbrake # Failed on 2024-06-12
      libgen-cli
      ;
  };
}
