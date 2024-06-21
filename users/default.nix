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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKjutIbvUj3CCDe18HkvtS14xvlJh3YBvPpdEAFmTYlq bryn.discord@gmail.com"
      ];
      theme =
        let
          catppuccinAccent = "sapphire";
          catppuccinFlavor = "flavor";
        in
        {
          inherit catppuccinAccent catppuccinFlavor;
          primary = "#ff0000";
          cursor = {
            name = "catppuccin-${catppuccinFlavor}-${catppuccinAccent}-cursors";
            package =
              pkgs.catppuccin-cursors."${lib.toUpper builtins.substring 0 1 catppuccinAccent}${
                builtins.substring 1 1000 catppuccinAccent
              }";
            size = 32;
          };
        };
    };
  };
}
