{ pkgs, ... }:
let
  # As of NixOS 24.05 - https://github.com/NixOS/nixpkgs/pull/225513
  # Can install packages in https://github.com/JuliaRegistries/General
  # Can find packages here: https://juliapackages.com/trending?sort=stars
  juliaPackages = [
    "Float8s"
    "JSON3"
  ];
in
{
  home.packages = builtins.attrValues {
    inherit (pkgs) hello;
    julia = pkgs.julia.withPackages juliaPackages;
  };
}
