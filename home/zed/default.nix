{ pkgs, ... }:
{
  home.packages = builtins.attrValues { inherit (pkgs) treefmt zed-editor; };
  # home.sessionVariables = {
  #   EDITOR = "hx";
  #   VISUAL = "hx";
  # };
}
