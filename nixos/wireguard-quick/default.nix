{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.wireguard-quick = {
    enable = lib.mkEnableOption "Soaffine WireGuard-Quick Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.wireguard-quick.enable {
    networking.wg-quick.interfaces = {
      ${config.sof.wireguard.interfaceName} = {
        address = [ "10.2.0.2/24" ];
        dns = [ "10.2.0.1" ];
        privateKeyFile = config.sof.wireguard.privateKeyFile;

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
