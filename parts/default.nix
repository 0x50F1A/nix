{ inputs, ... }:
{
  imports = [
    inputs.just-flake.flakeModule
    inputs.nix-topology.flakeModule
    inputs.nixos-flake.flakeModule
    inputs.pre-commit-hooks-nix.flakeModule
    inputs.treefmt-nix.flakeModule
  ];
  perSystem =
    {
      pkgs,
      lib,
      config,
      self',
      system,
      ...
    }:
    {
      imports = [
        ./devShells.nix
        ./just-flake.nix
        (import ./nix-topology.nix { inherit inputs system; })
        ./pre-commit.nix
        ./treefmt.nix
      ];
    };

  flake =
    {
      config,
      inputs,
      self',
      ...
    }:
    {
      imports = [
        ./nix-health.nix
        ./schemas.nix
      ];
    };
}
