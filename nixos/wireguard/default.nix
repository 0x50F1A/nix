{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.wireguard = {
    enable = lib.mkEnableOption "Soaffine WireGuard Configuration" // {
      default = true;
    };

    peerKey = lib.mkOption { type = lib.types.str; };
    peerAddress = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf config.sof.wireguard.enable {
    networking.wg-quick.interfaces = {
      wg0 = {
        address = [ "10.2.0.2/24" ];
        dns = [ "10.2.0.1" ];
        privateKeyFile = "/home/bryn/wireguard-keys/proton-private";

        peers = [
          {
            publicKey = config.sof.wireguard.peerKey;
            allowedIPs = [
              "0.0.0.0/0"
              "::/0"
            ];
            endpoint = config.sof.wireguard.peerAddress;
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
