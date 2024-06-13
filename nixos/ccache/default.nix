{ config, lib, ... }:
{
  _file = ./default.nix;
  options.sof.ccache = {
    enable = lib.mkEnableOption "Soaffine Ccache Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.ccache.enable {
    programs.ccache = {
      enable = true;

      # packageNames = ["ffmpeg"];
    };
  };
}
