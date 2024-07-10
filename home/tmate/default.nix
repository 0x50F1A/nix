{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.tmate = {
    enable = lib.mkEnableOption "Soaffine Tmate Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.tmate.enable {
    warnings = lib.optional (config.sof.nushell.enable) ''
      Tmate needs an API key to be set secretly.
    '';
    programs = {
      tmate = {
        enable = true;
      };
    };
  };
}
