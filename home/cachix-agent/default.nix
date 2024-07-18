{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.cachix-agent = {
    enable = lib.mkEnableOption "Soaffine Cachix Agent Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.cachix-agent.enable {
    warnings = lib.optional (config.sof.nushell.enable) ''
      Cachix Agent needs a credentials file from sops?
    '';
    services = {
      cachix-agent = {
        enable = true;
        name = "home-manager";
      };
    };
    # sops.secrets.cachix-agent-token = {
    #   path = config.services.cachix-agent.credentialsFile;
    # };
  };
}
