{
  treefmt = {
    flakeCheck = false;
    programs = {
      mdformat = {
        enable = true;
      };
      nixfmt = {
        enable = true;
      };
    };
    projectRootFile = "flake.nix";
  };
}
