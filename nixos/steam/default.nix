{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.steam = {
    enable = lib.mkEnableOption "Soaffine Steam Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.steam.enable {
    programs = {
      steam = {
        enable = true;
        extest = {
          enable = true;
        };
        extraCompatPackages = [ pkgs.proton-ge-bin ];
        gamescopeSession = {
          enable = true;
          args = [ "--expose-wayland -e" ];
        };
        localNetworkGameTransfers.openFirewall = true;
        remotePlay.openFirewall = true;
      };
    };

    environment.systemPackages = [
      pkgs.protonup-qt
      pkgs.lutris
    ];
  };
}
