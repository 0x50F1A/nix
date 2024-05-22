{
  pkgs,
  config,
  ...
}: {
  devShells = {
    default = pkgs.mkShell {
      name = "nixos";
      meta.description = "NixOS Development Environment";
      inputsFrom = [
        config.just-flake.outputs.devShell
        config.pre-commit.devShell
        config.treefmt.build.devShell
      ];
      packages = builtins.attrValues {
        inherit
          (pkgs)
          colmena
          convco
          just
          nix-health
          sops
          ;
      };
    };
  };
}
