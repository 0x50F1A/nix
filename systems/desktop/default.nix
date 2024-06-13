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
  ];
}
