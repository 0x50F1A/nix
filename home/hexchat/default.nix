{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.hexchat = {
    enable = lib.mkEnableOption "Soaffine Hexchat Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.hexchat.enable {
    programs = {
      hexchat = {
        enable = true;
      };
    };
  };
}
