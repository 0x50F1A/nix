{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.pet = {
    enable = lib.mkEnableOption "Soaffine Pet Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.pet.enable {
    programs = {
      pet = {
        enable = true;
      };
    };
  };
}
