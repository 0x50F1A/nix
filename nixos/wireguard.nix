_: {
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.2.0.2/24" ];
      dns = [ "10.2.0.1" ];
      privateKeyFile = "/home/bryn/wireguard-keys/proton-private";

      peers = [
        {
          publicKey = "5PtTH6ccK9HiiZQlmXDWbBBD7Uz4xO2pel3iVwYVwkA=";
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          endpoint = " 37.19.199.149:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
