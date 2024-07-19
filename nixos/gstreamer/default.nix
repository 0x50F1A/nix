{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;
  options.sof.gstreamer = {
    enable = lib.mkEnableOption "Soaffine Gstreamer Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.gstreaner.enable {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
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
    };
  };
}
