{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.sioyek = {
    enable = lib.mkEnableOption "Soaffine Sioyek Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.sioyek.enable {
    programs = {
      sioyek = {
        enable = true;
      };
    };
  };
}
