{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.wireguard = {
    enable = lib.mkEnableOption "Soaffine WireGuard Systemd Configuration" // {
      default = true;
    };
    interfaceName = lib.mkOption {
      type = lib.types.str;
      default = "wg0";
    };
    peerKey = lib.mkOption { type = lib.types.str; };
    peerAddress = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf config.sof.wireguard.enable {
    environment.systemPackages = [ pkgs.wireguard-tools ];
    networking.firewall.allowedUDPPorts = [ 51820 ];
    systemd.network = {
      enable = true;
      netdevs = {
        "10-${config.sof.wireguard.interfaceName}" = {
          enable = true;
          netdevConfig = {
            Kind = "wireguard";
            Name = config.sof.wireguard.interfaceName;
          };
          wireguardConfig = {
            PrivateKeyFile = "/run/wireguard-proton-private";
            ListenPort = 51820;
          };
          wireguardPeers = [
            {
              PublicKey = config.sof.wireguard.peerKey;
              AllowedIPs = [
                "0.0.0.0/0"
                "::/0"
              ];
              Endpoint = config.sof.wireguard.peerAddress;
            }
          ];
        };
      };
      networks."${config.sof.wireguard.interfaceName}" = {
        enable = true;
        matchConfig.Name = config.sof.wireguard.interfaceName;
        networkConfig = {
          Address = [ "10.2.0.2/24" ];
        };
        dns = [ "10.2.0.1" ];
      };
    };

    topology = {
      nodes.proton = {
        name = "⚛️🔐 Proton VPN";
        deviceType = "proton";
        interfaces = {
          remote = { };
        };
      };
      networks.proton = {
        name = "Proton VPN";
      };
    };
  };
}
