{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.scala = {
    enable = lib.mkEnableOption "Soaffine Scala Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.scala.enable {
    warnings = lib.optional (config.sof.scala.enable) ''
      Scala is enabled system-wide. While this is okay, a better strategy is to leverage devShells per-project.
    '';
    programs = {
      sbt = {
        enable = true;
      };
    };
  };
}
