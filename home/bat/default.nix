{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.bat = {
    enable = lib.mkEnableOption "Soaffine bat Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.bat.enable {
    programs = {
      bat = {
        enable = true;
        config = {
          theme = "Dracula";
        };
        # https://github.com/eth-p/bat-extras
        extraPackages = builtins.attrValues {
          inherit (pkgs.bat-extras)
            batdiff
            batgrep
            batman
            batpipe
            batwatch
            prettybat
            ;
        };
      };
    };
  };
}
