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
    warnings = lib.optional (config.sof.tailscale.enable) ''
      Tailscale is not using an auth key file.
    '';

    # In the future:
    # https://github.com/juanfont/headscale
    # May want to implement this to no longer depend upon the closed source black box control server

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

    systemd.network.networks."50-tailscale" = {
      enable = true;
      name = interfaceName;
      matchConfig = {
        Name = interfaceName;
      };
      linkConfig = {
        Unmanaged = true;
        ActivationPolicy = "manual";
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
