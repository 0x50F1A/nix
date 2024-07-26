{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.cachix-agent = {
    enable = lib.mkEnableOption "Soaffine Cachix Agent Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.cachix-agent.enable {
    services = {
      cachix-agent = {
        enable = true;
        name = "home-manager-agent";
        verbose = true;
      };
    };
  };
}
