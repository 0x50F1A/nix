{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.tmate = {
    enable = lib.mkEnableOption "Soaffine Tmate Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.tmate.enable {
    programs = {
      tmate = {
        enable = true;
      };
    };
  };
}
