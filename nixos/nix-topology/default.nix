{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;
  imports = [ flake.inputs.nix-topology.nixosModules.default ];
  options.sof.nix-topology = {
    enable = lib.mkEnableOption "Soaffine Nix-Topology Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.nix-topology.enable { };
}
