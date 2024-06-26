{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.jetbrains-remote = {
    enable = lib.mkEnableOption "Soaffine Jetbrains Remote Development Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.jetbrains-remote.enable {
    programs = {
      jetbrains-remote = {
        enable = true;
        ides = builtins.attrValues {
          inherit (pkgs.jetrains)
            datagrip
            dataspell
            rust-rover
            writerside
            ;
        };
      };
    };
  };
}
