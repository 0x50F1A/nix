{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.git-cliff = {
    enable = lib.mkEnableOption "Soaffine Git-Cliff Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.git-cliff.enable {
    programs = {
      git-cliff = {
        enable = true;
      };
    };
  };
}
