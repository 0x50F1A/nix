{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.gemini = {
    enable = lib.mkEnableOption "Soaffine Gemini Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.gemini.enable {
    home = {
      packages = builtins.attrValues { inherit (pkgs) amfora lagrange; };
    };
  };
}
