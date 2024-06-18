{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.fd = {
    enable = lib.mkEnableOption "Soaffine fd Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.fd.enable {
    programs = {
      fd = {
        enable = true;
      };
    };
  };
}
