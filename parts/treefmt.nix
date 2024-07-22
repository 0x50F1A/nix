{
  treefmt = {
    flakeCheck = false;
    programs = {
      deadnix = {
        enable = true;
      };
      jsonfmt = {
        enable = true;
      };
      mdformat = {
        enable = true;
      };
      nixfmt = {
        enable = true;
      };
      statix = {
        enable = true;
      };
      yamlfmt = {
        enable = true;
      };
    };
    projectRootFile = "flake.nix";
  };
}
