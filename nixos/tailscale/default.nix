{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.services.tailscale) interfaceName;
in
{
  _file = ./default.nix;

  options.sof.tailscale = {
    enable = lib.mkEnableOption "Soaffine Tailscale Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.tailscale.enable {
    environment.systemPackages = [ pkgs.tailscale ];
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };

    networking = {
      firewall = {
        enable = true;
        trustedInterfaces = [ interfaceName ];
        checkReversePath = "loose";
        interfaces.${interfaceName} = {
          allowedTCPPorts = [ config.services.tailscale.port ];
          allowedUDPPorts = [ config.services.tailscale.port ];
        };
      };
      interfaces = {
        ${interfaceName} = {
          useDHCP = false;
        };
      };
      nftables = {
        enable = true;
      };
    };

    topology.self = {
      interfaces = {
        tailscale0 = {
          type = "tailscale";
        };
      };
    };
  };
}
