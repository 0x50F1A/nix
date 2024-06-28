{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.navi = {
    enable = lib.mkEnableOption "Soaffine Navi Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.navi.enable {
    programs = {
      navi = {
        enable = true;
      };
    };
  };
}
