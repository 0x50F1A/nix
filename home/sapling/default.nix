{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.sapling = {
    enable = lib.mkEnableOption "Soaffine Sapling Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.sapling.enable {
    programs = {
      sapling = {
        enable = false; # Did not build on 2024-07-25
        userName = flake.config.affineUser.name;
        userEmail = flake.config.affineUser.email;
      };
    };
  };
}
