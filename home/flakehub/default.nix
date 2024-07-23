{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.flakehub = {
    enable = lib.mkEnableOption "Soaffine Flakehub Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.flakehub.enable {
    home.packages = builtins.attrValues { inherit (flake.inputs.fh.packages.${pkgs.system}) default; };
  };
}
