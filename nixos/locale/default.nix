{ config, lib, ... }:
{
  _file = ./default.nix;
  options.sof.locale = {
    enable = lib.mkEnableOption "Soaffine Locale Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.locale.enable {
    # Set your time zone.
    time.timeZone = "America/Edmonton";

    # Select internationalisation properties.
    i18n = {
      defaultLocale = "en_US.utf8";

      extraLocaleSettings = {
        LC_ADDRESS = "en_CA.utf8";
        LC_IDENTIFICATION = "en_CA.utf8";
        LC_MEASUREMENT = "en_CA.utf8";
        LC_MONETARY = "en_CA.utf8";
        LC_NAME = "en_CA.utf8";
        LC_NUMERIC = "en_CA.utf8";
        LC_PAPER = "en_CA.utf8";
        LC_TELEPHONE = "en_CA.utf8";
        LC_TIME = "en_CA.utf8";
      };
    };
  };
}
