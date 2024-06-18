{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.users = {
    enable = lib.mkEnableOption "Soaffine User Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.users.enable {
    users = {
      mutableUsers = false;
      defaultUserShell = pkgs.nushell;
      users.${flake.config.affineUser.name} = {
        isNormalUser = true;
        description = "Sofia";
        extraGroups = [
          "networkmanager"
          "wheel"
          "video"
          "audio"
        ];
        hashedPassword = "$y$j9T$Xrr9lauxcb9nD0P9h94qK/$NIjdpHuxCbrOOtp5Oo5g1zEBRaEskialcka5qm3VX29";
        openssh.authorizedKeys.keys = flake.config.affineUser.sshKeys;
      };
    };
  };
}
