{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.virtualisation = {
    enable = lib.mkEnableOption "Soaffine Virtualisation Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.virtualisation.enable {
    virtualisation = {
      docker = {
        enable = true;
        # storageDriver = "btrfs";
      };
    };

    users.users.bryn.extraGroups = [ "docker" ];

    users.extraGroups.docker.members = [ "bryn" ];
  };
}
