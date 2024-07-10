{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.wpaperd = {
    enable = lib.mkEnableOption "Soaffine Wpaperd Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.wpaperd.enable {
    programs = {
      wpaperd = {
        enable = true;
      };
    };
  };
}
