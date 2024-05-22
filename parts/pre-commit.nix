{
  pre-commit = {
    check.enable = true;
    settings = {
      hooks = {
        convco = {
          enable = true;
        };
        treefmt = {
          enable = true;
        };
      };
    };
  };
}
