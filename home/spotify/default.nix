{ pkgs, ... }:
{
  home.packages = builtins.attrValues { inherit (pkgs) ncspot psst spotify; };
}
