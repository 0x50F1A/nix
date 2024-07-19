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
        oxipng
        upscayl
        ;
      inherit (pkgs.gst_all_1)
        gst-editing-services
        gst-libav
        gst-plugins-bad
        gst-plugins-base
        gst-plugins-good
        gst-plugins-rs
        gst-plugins-ugly
        gst-plugins-viperfx
        gst-vaapi
        gstreamer
        ;
      inherit (flake.inputs.anipy-cli.packages.${(builtins.currentSystem or pkgs.system)}) default;
      inherit (flake.inputs.lobster.packages.${(builtins.currentSystem or pkgs.system)}) lobster;
    };
  };
}
