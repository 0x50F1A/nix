{ flake, ... }:
{
  imports = [ flake.inputs.aagl.nixosModules.default ];
  nix.settings = flake.inputs.aagl.nixConfig;
  programs = {
    anime-games-launcher.enable = true;
    honkers-railway-launcher.enable = true;
  };
}
