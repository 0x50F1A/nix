{ config, lib, ... }:
{
  _file = ./default.nix;
  options.sof.mtr = {
    enable = lib.mkEnableOption "Soaffine MTR Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.mtr.enable {
    programs.mtr = {
      enable = true;
    };
  };
}
