{ config, flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    inputs.nix-topology.nixosModules.default
    self.nixosModules.default
    self.nixosModules.base
    self.nixosModules.commandline
    self.nixosModules.development
    self.nixosModules.graphical
    self.nixosModules.intel-hd
    self.nixosModules.networking
    self.nixosModules.wayland
    self.nixosModules.testing
    ./hardware-configuration.nix
    {
      sof.wireguard = {
        peerKey = "wP/7Xi9sTiO1XMpLXf/OUJiJc1E0PA3KyskMtGajEFA=";
        peerAddress = "146.70.202.2:51820";
      };
      systemd.network.networks = {
        "10-wireless" = {
          matchConfig = {
            Name = "wnp0s1";
          };
          inherit (config.systemd.network.networks."40-wireless") networkConfig;
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

          hardware = {
            info = "Acer Chromebook Spin 713";
          };
        };
      };
    }
  ];
}
