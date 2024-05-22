_: {
  perSystem = {
    pkgs,
    lib,
    config,
    self',
    ...
  }: {
    imports = [
      ./devShells.nix
      ./just-flake.nix
      ./pre-commit.nix
      ./treefmt.nix
    ];
  };

  flake = {
    config,
    inputs,
    self',
    ...
  }: {
    imports = [
      ./nix-health.nix
    ];
  };
}
