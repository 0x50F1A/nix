{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit (pkgs) warp-terminal;
  };
}
