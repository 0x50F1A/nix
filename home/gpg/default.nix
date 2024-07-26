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
      default = true;
    };
  };

  config = lib.mkIf config.sof.gpg.enable {
    programs = {
      gpg = {
        enable = true;
        homedir = "${config.xdg.dataHome}/gnupg";
        mutableKeys = false;
        mutableTrust = false;
      };
    };

    services = {
      gpg-agent = {
        enable = true;
        enableExtraSocket = true;
        enableSshSupport = true;
        pinentryPackage = if config.qt.enable then pkgs.pinentry-qt else pkgs.pinentry-curses;
        sshKeys = [ ];
      };
    };
  };
}
