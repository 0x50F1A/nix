{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  imports = [ flake.inputs.sops-nix.homeManagerModules.sops ];

  options.sof.sops = {
    enable = lib.mkEnableOption "Soaffine Sops Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.sops.enable {
    sops = {
      age = {
        keyFile = /home/bryn/.config/sops/age/keys.txt;
        sshKeyPaths = [ /home/${config.home.username}/.ssh/id_ed25519 ];
      };

      secrets = {
        atuin = {
          sopsFile = ../../secrets/services.yaml;
          path = config.programs.atuin.settings.key_path;
        };
        tmate = {
          sopsFile = ../../secrets/services.yaml;
        };
        cachix-agent-token = {
          sopsFile = ../../secrets/services.yaml;
          path = config.services.cachix-agent.credentialsFile;
        };
      };
    };
  };
}
