{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.java = {
    enable = lib.mkEnableOption "Soaffine Java Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.java.enable {
    warnings = lib.optional (config.sof.java.enable) ''
      Java is enabled system-wide. While this is okay, a better strategy is to leverage devShells per-project.
    '';
    programs = {
      java = {
        enable = true;
      };
    };
  };
}
