{ inputs, system, ... }:
{
  _module.args.pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [ inputs.nix-topology.overlays.default ];
  };
}
