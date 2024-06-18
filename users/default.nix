{ lib, pkgs, ... }:
{
  options.affineUser = {
    name = lib.mkOption { type = lib.types.str; };
    email = lib.mkOption { type = lib.types.str; };
    sshKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = ''
        SSH public keys
      '';
    };
    theme = {
      primary = lib.mkOption { type = lib.types.str; };
      secondary = lib.mkOption { type = lib.types.str; };
      background = lib.mkOption { type = lib.types.str; };
      cursor = {
        name = lib.mkOption { type = lib.types.str; };
        package = lib.mkOption { type = lib.types.package; };
        size = lib.mkOption { type = lib.types.int; };
      };
    };
  };
  config = {
    affineUser = {
      name = "bryn";
      email = "bryn.discord@gmail.com";
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOBDGkggZqAPjUEtzl5tJLLLOh8OMElRYSTZqUNnYENH bryn@penguin"
      ];
      theme.primary = "#ff0000";
      theme.cursor.name = "catppuccin-mocha-sapphire-cursors";
      theme.cursor.package = pkgs.catppuccin-cursors.mochaSapphire;
      theme.cursor.size = 32;
    };
  };
}
