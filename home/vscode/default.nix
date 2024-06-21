{ pkgs, ... }:
let
  vsce = pkgs.vscode-extensions;
in
{
  programs = {
    vscode = {
      enable = true;
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
      # package = (pkgs.vscode.override {}).overrideAttrs (oldAttrs: {
      #   src = builtins.fetchurl {
      #     url = "https://downloader.cursor.sh/linux/appImage/x64";
      #     sha256 = "sha256:0z7zkdfmzswciifyj2mqn3ksa091sx4a6jrqh62ygkqprxigkb1x";
      #   };
      #   dontUnpack = true;
      #   installPhase = ''
      #     mkdir -p $out/bin
      #     chmod a+x $src
      #     cp $src $out/bin/cursor-x86_64.AppImage
      #     ln -sf $out/bin/cursor
      #   '';
      #   version = "latest";
      # });
      # haskell = {
      #   enable = true;
      #   # hie = {
      #   #   enable = true;
      #   # };
      # };
      mutableExtensionsDir = true;
      extensions = builtins.attrValues {
        inherit (vsce.bbenoist) nix;
        inherit (vsce.catppuccin) catppuccin-vsc;
        inherit (vsce.github)
          copilot
          copilot-chat
          vscode-github-actions
          vscode-pull-request-github
          ;
      };
    };
  };
}
