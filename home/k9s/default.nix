{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.k9s = {
    enable = lib.mkEnableOption "Soaffine k9s Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.k9s.enable {
    programs = {
      k9s = {
        enable = true;
      };
    };
  };
}
