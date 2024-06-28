{ lib, pkgs, ... }:
{
  _file = ./default.nix;
  options.affineUser = {
    name = lib.mkOption { type = lib.types.str; };
    email = lib.mkOption { type = lib.types.str; };
    nixProvider = lib.mkOption { type = lib.types.str; };
    sshKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = ''
        SSH public keys
      '';
    };
    theme = {
      catppuccinAccent = lib.mkOption { type = lib.types.str; };
      catppuccinFlavor = lib.mkOption { type = lib.types.str; };
      cursor = {
        name = lib.mkOption { type = lib.types.str; };
        package = lib.mkOption { type = lib.types.package; };
        size = lib.mkOption { type = lib.types.int; };
      };
      defaultFonts = {
        emoji = lib.mkOption { type = lib.types.listOf lib.types.str; };
        monospace = lib.mkOption { type = lib.types.listOf lib.types.str; };
        sansSerif = lib.mkOption { type = lib.types.listOf lib.types.str; };
        serif = lib.mkOption { type = lib.types.listOf lib.types.str; };
      };
      terminal = {
        fontSize = lib.mkOption { type = lib.types.float; };
      };
    };
  };
  config = {
    affineUser = {
      name = "bryn";
      email = "bryn.discord@gmail.com";
      nixProvider = "lix";
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOBDGkggZqAPjUEtzl5tJLLLOh8OMElRYSTZqUNnYENH bryn@penguin"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKjutIbvUj3CCDe18HkvtS14xvlJh3YBvPpdEAFmTYlq bryn.discord@gmail.com"
      ];
      theme =
        let
          catppuccinAccent = "sapphire";
          catppuccinFlavor = "mocha";
          catppuccinPackage = "${catppuccinFlavor}${lib.toUpper (builtins.substring 0 1 catppuccinAccent)}${
            (builtins.substring 1 1000 catppuccinAccent)
          }";
        in
        {
          inherit catppuccinAccent catppuccinFlavor;
          cursor = {
            name = "catppuccin-${catppuccinFlavor}-${catppuccinAccent}-cursors";
            package = pkgs.catppuccin-cursors.${catppuccinPackage};
            size = 32;
          };
          defaultFonts = {
            monospace = [
              "JetBrains Mono"
              "MesloLGS NF"
              "MesloLGS Nerd Font Mono"
              "Noto Color Emoji"
            ];
            sansSerif = [
              "Lexend"
              "Noto Color Emoji"
            ];
            serif = [
              "Noto Serif"
              "Noto Color Emoji"
            ];
            emoji = [ "Noto Color Emoji" ];
          };
          terminal = {
            fontSize = 16.0;
          };
        };
    };
  };
}
