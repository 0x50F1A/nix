{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.broot = {
    enable = lib.mkEnableOption "Soaffine Broot Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.broot.enable {
    programs = {
      broot = {
        enable = true;
        settings = {
          modal = true;
        };
      };
    };
  };
}
