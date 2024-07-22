{ config, flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.nixosModules.default
    self.nixosModules.base
    self.nixosModules.commandline
    self.nixosModules.development
    self.nixosModules.gaming
    self.nixosModules.graphical
    self.nixosModules.networking
    self.nixosModules.nvidia
    self.nixosModules.wayland
    self.nixosModules.testing
    ./hardware-configuration.nix
    {
      sof.wireguard = {
        peerKey = "5PtTH6ccK9HiiZQlmXDWbBBD7Uz4xO2pel3iVwYVwkA=";
        peerAddress = "37.19.199.149:51820";
      };
      systemd.network.networks = {
        "10-ethernet" = {
          matchConfig = {
            Name = "eno1";
          };
          inherit (config.systemd.network.networks."40-wired") networkConfig;
        };
      };
      topology = {
        nodes = {
          proton.interfaces.tunnel = {
            network = "proton";
            physicalConnections = [ (config.lib.topology.mkConnection config.networking.hostName "wg0") ];
          };
        };
        self = {
          name = "🌳 Main Development Desktop";
          hardware = {
            info = "Intel i7-10700 + NVIDIA GeForce RTX 3070";
          };
        };
      };
    }
  ];
}
