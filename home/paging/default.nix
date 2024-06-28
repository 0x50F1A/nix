{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.paging = {
    enable = lib.mkEnableOption "Soaffine Pager Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.paging.enable {
    programs = {
      less = {
        enable = true;
      };
      lesspipe = {
        enable = true;
      };
    };
    home.packages = builtins.attrValues {
      inherit (pkgs)
        jless
        lnav
        moar
        ov
        vgrep
        ydiff
        ;
    };
  };
}
