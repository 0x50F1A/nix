{ inputs, ... }:
{
  imports = [
    inputs.just-flake.flakeModule
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
      ...
    }:
    {
      imports = [
        ./devShells.nix
        ./just-flake.nix
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
