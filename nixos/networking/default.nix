{ config, lib, ... }:
let
  nameServers = [
    "1.1.1.1#one.one.one.one"
    "1.0.0.1#one.one.one.one"
  ];
  networkConfig = {
    DHCP = "yes";
    DNSSEC = "yes";
    DNSOverTLS = "yes";
    DNS = nameServers;
  };
in
{
  _file = ./default.nix;
  options.sof.networking = {
    enable = lib.mkEnableOption "Soaffine Networking Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.networking.enable {
    networking = {
      firewall = {
        allowPing = true;
      };
      nameservers = nameServers;
      networkmanager.enable = true;
      tcpcrypt.enable = true;
    };

    services.resolved = {
      enable = true;
      dnssec = "true";
      domains = [ "~." ];
      fallbackDns = nameServers;
      dnsovertls = "true";
    };

    systemd.network = {
      enable = true;
      networks = {
        "40-wired" = {
          enable = true;
          name = "en*";
          inherit networkConfig;
        };
        "40-wireless" = {
          enable = true;
          name = "wlp*";
          inherit networkConfig;
        };
      };
    };

    # https://wiki.nixos.org/wiki/Systemd-networkd#network-online.target
    systemd.network.wait-online.anyInterface = true;

    users.extraUsers.tcpcryptd.group = "tcpcryptd";
    users.extraGroups.tcpcryptd = { };
  };
}
