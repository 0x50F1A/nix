{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.thunderbird = {
    enable = lib.mkEnableOption "Soaffine Thunderbird Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.thunderbird.enable {
    programs = {
      thunderbird = {
        enable = true;
        profiles = {
          default = {
            isDefault = true;
          };
        };
      };
    };
  };
}
