{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.havoc = {
    enable = lib.mkEnableOption "Soaffine Havoc Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.havoc.enable {
    warnings = lib.optional (config.sof.nushell.enable) ''
      Nushell currently depends on a hack for environment variables, to support things like Fzf.
    '';
    programs = {
      havoc = {
        enable = true;
      };
    };
  };
}
