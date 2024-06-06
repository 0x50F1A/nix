{
  description = "Julia Development Environment";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    just-flake = {
      url = "github:juspay/just-flake";
    };
    nixos-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs.follows = "nixos-unstable";
    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    commit-lockfile-summary = "build(inputs): ⬆️ bump flake.lock";
    extra-substituters = [ "https://sofia.cachix.org" ];
    extra-trusted-public-keys = [ "sofia.cachix.org-1:xqwE0S1tPcsqfoayNUC0YdsDpj47LQ3Q+YTdDI1WwtE=" ];
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [ ./parts ];
    };
}
