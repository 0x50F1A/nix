{ config, lib, ... }:
{
  _file = ./default.nix;
  options.sof.darling = {
    enable = lib.mkEnableOption "Soaffine Darling Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.darling.enable {
    programs.darling = {
      enable = false;
    };
  };
}
