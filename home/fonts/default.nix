{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.fonts = {
    enable = lib.mkEnableOption "Soaffine Fonts Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.fonts.enable {
    fonts = {
      fontconfig = {
        enable = true;
        inherit (flake.config.affineUser.theme) defaultFonts;
      };
    };
  };
}
