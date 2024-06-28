{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.manpages = {
    enable = lib.mkEnableOption "Soaffine Manpages Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.manpages.enable {
    programs.man = {
      enable = true;
      generateCaches = true;
    };
  };
}
