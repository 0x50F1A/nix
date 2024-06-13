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

  options.sof.wireguard-systemd = {
    enable = lib.mkEnableOption "Soaffine WireGuard Systemd Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.wireguard-systemd.enable {
    environment.systemPackages = [ pkgs.wireguard-tools ];
    systemd.network = {
      enable = true;
      netdevs = {
        "99-${interfaceName}" = {
          enable = true;
          netdevConfig = {
            Kind = "wireguard";
            Name = interfaceName;
          };
          wireguardConfig = {
            PrivateKeyFile = "/home/bryn/wireguard-keys/proton-private";
            ListenPort = 9918;
          };
          wireguardPeers = [
            {
              PublicKey = "5PtTH6ccK9HiiZQlmXDWbBBD7Uz4xO2pel3iVwYVwkA=";
              AllowedIPs = [ "0.0.0.0/0" ];
              Endpoint = "37.19.199.149:51820";
            }
          ];
        };
      };
      networks."99-${interfaceName}" = {
        enable = true;
        matchConfig.Name = interfaceName;
        networkConfig = {
          Address = [ "10.2.0.2/32" ];
        };
        dns = [ "10.2.0.1" ];
      };
    };
  };
}
