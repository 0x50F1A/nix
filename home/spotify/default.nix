{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.spotify = {
    enable = lib.mkEnableOption "Soaffine Spotify Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.spotify.enable {
    home.packages = builtins.attrValues { inherit (pkgs) spotify; };
  };
}
