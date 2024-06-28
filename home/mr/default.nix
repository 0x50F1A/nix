{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.mr = {
    enable = lib.mkEnableOption "Soaffine Myrepos Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.mr.enable {
    programs = {
      mr = {
        enable = true;
      };
    };
  };
}
