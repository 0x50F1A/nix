{
  treefmt = {
    flakeCheck = false;
    programs = {
      nixfmt-rfc-style = {
        enable = true;
      };
    };
    projectRootFile = "flake.nix";
  };
}
