{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.gpg = {
    enable = lib.mkEnableOption "Soaffine GnuPG Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.gpg.enable {
    programs = {
      gpg = {
        enable = true;
      };
    };

    services = {
      gpg-agent = {
        enable = true;
        enableSshSupport = true;
        sshKeys = [ ];
        enableExtraSocket = true;
        pinentryPackage = if config.qt.enable then pkgs.pinentry-qt else pkgs.pinentry-curses;
      };
    };
  };
}
