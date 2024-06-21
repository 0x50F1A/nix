{ flake, ... }:
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
    }
  ];
}
