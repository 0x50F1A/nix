{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.jq = {
    enable = lib.mkEnableOption "Soaffine JQ Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.jq.enable {
    programs = {
      jq = {
        enable = true;
      };
    };
  };
}
