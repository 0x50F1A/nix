{ pkgs, config, ... }:
{
  devShells = {
    default = pkgs.mkShell {
      name = "julia-dev";
      meta.description = "Julia Development Environment";
      inputsFrom = [
        config.just-flake.outputs.devShell
        config.pre-commit.devShell
        config.treefmt.build.devShell
      ];
      packages =
        let
          # As of NixOS 24.05 - https://github.com/NixOS/nixpkgs/pull/225513
          # Can install packages in https://github.com/JuliaRegistries/General
          # Can find packages here: https://juliapackages.com/trending?sort=stars
          registeredJuliaPackages = [ "Plots" ];
        in
        builtins.attrValues {
          inherit (pkgs) convco just;
          julia = pkgs.julia.withPackages registeredJuliaPackages;
        };
    };
  };
}
