{flake, ...}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    self.homeModules.base
    self.homeModules.commandline
    self.homeModules.extra
    self.homeModules.graphical
    self.homeModules.internet
    self.homeModules.media
    self.homeModules.programming
    self.homeModules.security-tools
    ./configuration.nix
  ];
}
