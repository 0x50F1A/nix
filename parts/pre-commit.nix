{
  pre-commit = {
    check.enable = false;
    settings = {
      hooks = {
        convco = {
          enable = false;
        };
        treefmt = {
          enable = false;
        };
      };
    };
  };
}
