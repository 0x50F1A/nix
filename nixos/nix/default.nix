{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;
  options.sof.nix = {
    enable = lib.mkEnableOption "Soaffine Nix Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.nix.enable {
    nix = {
      package = lib.mkMerge [
        (lib.mkIf config.sof.lix.enable pkgs.lix)
        (lib.mkIf (!config.sof.lix.enable) pkgs.nixVersions.git)
      ];
      nixPath = [ "nixpkgs=${pkgs.path}" ];
      settings = {
        auto-allocate-uids = true;
        auto-optimise-store = true;
        builders-use-substitutes = true;
        experimental-features = [
          "auto-allocate-uids"
          "cgroups"
          "flakes"
          "nix-command"
          "no-url-literals"
          "parse-toml-timestamps"
        ];
        keep-outputs = true;
        keep-derivations = true;
        use-cgroups = true;
        trusted-users = [
          "root"
          flake.config.affineUser.name
        ];
        substituters = [ "https://nix-community.cachix.org" ];
        trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };
      optimise = {
        automatic = true;
      };
      registry.nixpkgs.flake = flake.inputs.nixpkgs;
    };

    nixpkgs = {
      config = {
        allowBroken = true;
        allowUnfree = true;
        allowUnsupportedSystem = true;
      };
      overlays = [ ];
    };
  };
}
