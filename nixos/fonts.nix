{pkgs, ...}: {
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
        inherit
          (pkgs)
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
}
