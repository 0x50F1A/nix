{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;
  imports = [ flake.inputs.aagl.nixosModules.default ];
  options.sof.hoyoverse = {
    enable = lib.mkEnableOption "Soaffine Hoyoverse Games Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.hoyoverse.enable {
    nix.settings = flake.inputs.aagl.nixConfig;
    programs = {
      anime-games-launcher.enable = true;
      honkers-railway-launcher.enable = true;
      sleepy-launcher.enable = true;
    };
  };
}
