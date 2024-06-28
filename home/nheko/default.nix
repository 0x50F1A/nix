{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.nheko = {
    enable = lib.mkEnableOption "Soaffine Nheko Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.nheko.enable {
    programs = {
      nheko = {
        enable = true;
        settings = {
          general.disableCertificateValidation = false;
        };
      };
    };
  };
}
