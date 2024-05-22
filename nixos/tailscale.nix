{
  config,
  pkgs,
  ...
}: let
  inherit (config.services.tailscale) interfaceName;
in {
  # In the future:
  # https://github.com/juanfont/headscale
  # May want to implement this to no longer depend upon  the closed source black box control server

  # https://tailscale.com/kb/1019/subnets?tab=linux#enable-ip-forwarding
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = "1";
    "net.ipv6.conf.all.forwarding" = "1";
  };

  environment.systemPackages = [pkgs.tailscale];
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  networking = {
    firewall = {
      enable = true;
      trustedInterfaces = [interfaceName];
      checkReversePath = "loose";
      interfaces.${interfaceName} = {
        allowedTCPPorts = [22 config.services.tailscale.port];
        allowedTCPPortRanges = [
          {
            from = 8000;
            to = 8999;
          }
        ];
        allowedUDPPorts = [config.services.tailscale.port];
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
}
