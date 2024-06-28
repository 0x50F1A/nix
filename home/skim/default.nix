{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.skim = {
    enable = lib.mkEnableOption "Soaffine Skim Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.skim.enable {
    warnings = lib.optional (config.sof.skim.enable) ''
      Skim was unmaintained at last check: https://github.com/lotabout/skim
    '';
    programs = {
      skim = {
        enable = true;
      };
    };
  };
}
