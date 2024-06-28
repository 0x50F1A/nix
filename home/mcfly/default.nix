{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.mcfly = {
    enable = lib.mkEnableOption "Soaffine Mcfly Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.mcfly.enable {
    programs = {
      mcfly = {
        enable = true;
        fuzzySearchFactor = 3;
        fzf.enable = true;
        keyScheme = "vim";
      };
    };
  };
}
