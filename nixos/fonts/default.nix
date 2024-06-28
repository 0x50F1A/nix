{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;
  options.sof.fonts = {
    enable = lib.mkEnableOption "Soaffine Font Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.fonts.enable {
    warnings = lib.optional (config.sof.fonts.enable) ''
      NixOS wide defaultFonts currently disabled because it messes up Firefox?
    '';
    fonts = {
      enableDefaultPackages = true;
      enableGhostscriptFonts = true;
      fontconfig = {
        cache32Bit = true;
        # inherit (flake.config.affineUser.theme) defaultFonts;
      };
      fontDir = {
        enable = true;
        decompressFonts = true;
      };
      packages =
        builtins.attrValues {
          inherit (pkgs)
            material-icons
            material-design-icons
            noto-fonts
            noto-fonts-emoji
            fira-code
            fira-code-symbols
            fira-mono
            cascadia-code
            b612
            source-code-pro
            jetbrains-mono
            font-awesome
            corefonts
            roboto
            lexend
            ;
        }
        ++ [
          (pkgs.nerdfonts.override {
            fonts = [
              "FiraCode"
              "Meslo"
            ];
          })
        ];
    };
  };
}
