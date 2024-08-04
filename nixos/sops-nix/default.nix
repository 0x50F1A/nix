{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;
  imports = [ flake.inputs.sops-nix.nixosModules.sops ];
  options.sof.sops = {
    enable = lib.mkEnableOption "Soaffine Sops Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.sops.enable {
    sops = {
      age = {
        keyFile = /home/bryn/.config/sops/age/keys.txt;
        sshKeyPaths = [ /home/bryn/.ssh/id_ed25519 ];
      };
      secrets = {
        "proton-${config.networking.hostName}" = {
          owner = "systemd-network";
          group = "systemd-network";
          path = config.sof.wireguard.privateKeyFile;
          sopsFile = ../../secrets/api.yaml;
        };
      };
    };
  };
}
