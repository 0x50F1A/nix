{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.apple-music = {
    enable = lib.mkEnableOption "Soaffine Apple Music Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf (config.sof.apple-music.enable && pkgs.stdenv.hostPlatform.isLinux) {
    warnings = lib.optional (config.sof.apple-music.enable) ''
      Old cider is no longer actively maintained https://github.com/ciderapp/Cider
      New version costs $4 https://cidercollective.itch.io/cider
    '';
    home.packages = [ pkgs.cider ];
  };
}
