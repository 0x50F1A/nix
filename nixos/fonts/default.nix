{
  config,
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
    fonts = {
      enableDefaultPackages = true;
      fontconfig = {
        cache32Bit = true;
      };
      fontDir = {
        enable = true;
        decompressFonts = true;
      };
      packages =
        builtins.attrValues {
          inherit (pkgs)
            noto-fonts-emoji
            fira-code
            cascadia-code
            b612
            source-code-pro
            jetbrains-mono
            font-awesome
            corefonts
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
