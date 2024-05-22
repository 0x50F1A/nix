{
  flake,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.nixVersions.git;
    settings = {
      auto-allocate-uids = true;
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = "auto-allocate-uids cgroups flakes nix-command no-url-literals parse-toml-timestamps";
      keep-outputs = true;
      keep-derivations = true;
      use-cgroups = true;
      trusted-users = ["root" flake.config.people.myself];
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
    overlays = [];
  };
}
