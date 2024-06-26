{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.info = {
    enable = lib.mkEnableOption "Soaffine GNU Info Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.info.enable {
    programs = {
      info = {
        enable = true;
      };
    };
  };
}
