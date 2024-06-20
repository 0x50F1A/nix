{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
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
    }
  ];
}
