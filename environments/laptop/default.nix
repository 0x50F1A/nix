{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (self) homeModules;
in
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    homeModules.base
    homeModules.commandline
    homeModules.extra
    homeModules.graphical
    homeModules.internet
    homeModules.media
    homeModules.programming
    homeModules.security-tools
    ./configuration.nix
  ];
}
