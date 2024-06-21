{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.catppuccin = {
    enable = lib.mkEnableOption "Soaffine Catppuccin Theme Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.catppuccin.enable {
    catppuccin = {
      enable = lib.mkForce false;
      accent = flake.config.affineUser.theme.catppuccinAccent;
      flavor = flake.config.affineUser.theme.catppuccinFlavor;
    };
    programs = {
      gitui = {
        catppuccin.enable = true;
      };
    };
  };
}
