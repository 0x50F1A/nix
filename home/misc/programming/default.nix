{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      fx
      htmlq
      nixfmt-rfc-style
      serverless
      tidy-viewer
      xsv
      ;
    inherit (pkgs.python3Packages) yq;
  };
}
