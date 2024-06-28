{
  config,
  lib,
  pkgs,
  ...
}:
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
  _file = ./default.nix;

  options.sof.julia = {
    enable = lib.mkEnableOption "Soaffine Julia Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.julia.enable {
    warnings = lib.optional (config.sof.julia.enable) ''
      Julia is enabled system-wide. While this is okay, a better strategy is to leverage devShells per-project.
    '';
    home.packages = builtins.attrValues {
      julia = pkgs.julia.withPackages juliaPackages;
    };
  };
}
