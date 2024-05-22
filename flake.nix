{
  description = "Affine Typed NixOS";

  inputs = {
    # attic = {
    #   url = "https://flakehub.com/f/zhaofengli/attic/*.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # colmena-flake = {
    #   url = "github:juspay/colmena-flake";
    # };

    # disko = {
    #   url = "https://flakehub.com/f/nix-community/disko/1.6.0.tar.gz";
    #   inputs.nixpkgs.url = "nixpkgs";
    # };

    # dream2nix = {
    #   url = "github:nix-community/dream2nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # fh = {
    #   url = "https://flakehub.com/f/DeterminateSystems/fh/*.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    # flake-programs-sqlite = {
    #   url = "github:wamserma/flake-programs-sqlite";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    flake-schemas = {
      url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*.tar.gz";
    };

    home-manager.follows = "home-manager-unstable";

    # home-manager-stable = {
    #   url = "https://flakehub.com/f/nix-community/home-manager/*.tar.gz";
    #   inputs.nixpkgs.follows = "nixos-stable";
    # };

    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    # impermanence = {
    #   url = "github:nix-community/impermanence";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    ### Impermanence alternative?
    # instransience = {
    #   url = "github:anna328p/intransience";
    # };

    just-flake = {
      url = "github:juspay/just-flake";
    };

    # lanzaboote = {
    #   url = "https://flakehub.com/f/nix-community/lanzaboote/0.3.0.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nh = {
    #   url = "github:viperML/nh";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nixci = {
    #   url = "github:srid/nixci";
    # };

    # nix-darwin = {
    #   url = "github:lnl7/nix-darwin";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nix-index-database = {
    #   url = "github:nix-community/nix-index-database";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nix-vscode-extensions = {
    #   url = "github:nix-community/nix-vscode-extensions";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixos-flake = {
      url = "github:srid/nixos-flake";
    };

    # nixos-2311 = {
    #   url = "github:nixos/nixpkgs/nixos-23.11";
    # };

    # # nixos-hardware = {
    # #   url = "github:nixos/nixos-hardware";
    # # };

    # nixos-stable = {
    #   url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
    # };

    nixos-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    # nixos-vscode-server = {
    #   url = "github:nix-community/nixos-vscode-server";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nixos-wsl = {
    #   url = "github:nix-community/NixOS-WSL";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixpkgs.follows = "nixos-unstable";

    # nixpkgs-weekly = {
    #   url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/*.tar.gz";
    # };

    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nuenv = {
    #   url = "https://flakehub.com/f/DeterminateSystems/nuenv/*.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.nixpkgs-stable.follows = "nixos-stable";
    };

    # process-compose-flake = {
    #   url = "github:Platonic-Systems/process-compose-flake";
    # };

    # services-flake = {
    #   url = "github:juspay/services-flake";
    # };

    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    # };

    # srvos = {
    #   url = "github:nix-community/srvos";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    systems = {
      url = "github:nix-systems/default";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # vaultModule = {
    #   url = "github:DeterminateSystems/nixos-vault-service/main";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  nixConfig = {
    commit-lockfile-summary = "build(inputs): ⬆️ bump flake.lock";
    extra-substituters = ["https://sofia.cachix.org"];
    extra-trusted-public-keys = ["sofia.cachix.org-1:xqwE0S1tPcsqfoayNUC0YdsDpj47LQ3Q+YTdDI1WwtE="];
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      imports = [
        inputs.just-flake.flakeModule
        inputs.nixos-flake.flakeModule
        inputs.pre-commit-hooks-nix.flakeModule
        inputs.treefmt-nix.flakeModule
        ./home
        ./nixos
        ./parts
        ./users
      ];

      flake = {
        nixosConfigurations.desktop =
          inputs.self.nixos-flake.lib.mkLinuxSystem
          ./systems/desktop;

        schemas = inputs.flake-schemas.schemas;
      };

      perSystem = {
        config,
        self,
        system,
        ...
      }: {
        legacyPackages.homeConfigurations.desktop =
          inputs.self.nixos-flake.lib.mkHomeConfiguration
          (import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          })
          ./environments/desktop;
      };
    };
}
