{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.ncmpcpp = {
    enable = lib.mkEnableOption "Soaffine ncmpcpp Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.ncmpcpp.enable {
    programs = {
      ncmpcpp = {
        enable = true;
      };
    };
  };
}
