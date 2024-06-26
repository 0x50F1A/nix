{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.joshuto = {
    enable = lib.mkEnableOption "Soaffine Joshuto Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.joshuto.enable {
    programs = {
      joshuto = {
        enable = true;
      };
    };
  };
}
