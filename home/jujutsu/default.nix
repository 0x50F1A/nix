{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.jujutsu = {
    enable = lib.mkEnableOption "Soaffine Jujutsu Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.jujutsu.enable {
    programs = {
      jujutsu = {
        enable = true;
      };
    };

    home.packages = builtins.attrValues {
      inherit (flake.inputs.jj_tui.packages.${pkgs.system}) default; # Disabled on 2024-06-25 Because the ocaml overlay uses URL literals
    };
  };
}
