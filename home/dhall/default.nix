{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.dhall = {
    enable = lib.mkEnableOption "Soaffine Dhall Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.dhall.enable {
    warnings = lib.optional (config.sof.dhall.enable) ''
      Dhall is enabled system-wide. While this is okay, a better strategy is to leverage devShells per-project.
    '';

    home.packages = builtins.attrValues {
      inherit (pkgs)
        dhall
        dhall-bash
        dhall-docs
        dhall-json
        dhall-lsp-server
        dhall-nix
        dhall-nixpkgs
        dhall-yaml
        ;
      inherit (pkgs.dhallPackages)
        Prelude
        dhall-cloudformation
        dhall-grafana
        dhall-kubernetes
        ;
      inherit (pkgs.haskellPackages)
        dhall-check
        dhall-csv
        dhall-openapi
        dhall-secret
        dhall-text
        dhall-toml
        ;
    };
  };
}
