{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.deployment = {
    enable = lib.mkEnableOption "Soaffine Deployment Tools Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.deployment.enable {
    warnings = lib.optional (config.sof.deployment.enable) ''
      Deployment tools are enabled in a home-manager configuration. Consider enabling them at the devShell level instead.
    '';
    home.packages = builtins.attrValues { inherit (pkgs) deploy-rs; };
  };
}
