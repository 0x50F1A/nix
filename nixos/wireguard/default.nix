{
  config,
  lib,
  pkgs,
  ...
}:
let
  interfaceName = "wg0";
in
{
  _file = ./default.nix;

  options.sof.wireguard = {
    enable = lib.mkEnableOption "Soaffine WireGuard Systemd Configuration" // {
      default = true;
    };

    peerKey = lib.mkOption { type = lib.types.str; };
    peerAddress = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf config.sof.wireguard.enable {
    warnings = lib.optional (config.sof.wireguard.enable) ''
      WG key has not yet been SOPS encrypted.
    '';
    environment.systemPackages = [ pkgs.wireguard-tools ];
    networking.firewall.allowedUDPPorts = [ 51820 ];
    systemd.network = {
      enable = true;
      netdevs = {
        "10-${interfaceName}" = {
          enable = true;
          netdevConfig = {
            Kind = "wireguard";
            Name = interfaceName;
          };
          wireguardConfig = {
            PrivateKeyFile = "/run/wireguard-keys/proton-private";
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
      networks."${interfaceName}" = {
        enable = true;
        matchConfig.Name = interfaceName;
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
