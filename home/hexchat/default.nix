{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.hexchat = {
    enable = lib.mkEnableOption "Soaffine Hexchat Home Configuration" // {
      default = false;
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
