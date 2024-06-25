{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.gradle = {
    enable = lib.mkEnableOption "Soaffine Gradle Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.gradle.enable {
    warnings = lib.optional (config.sof.gradle.enable) ''
      Gradle is enabled system-wide. While this is okay, a better strategy is to leverage devShells per-project.
    '';
    programs = {
      gradle = {
        enable = true;
        home = "${config.xdg.dataHome}/gradle";
        settings = {
          "org.gradle.caching" = true;
          "org.gradle.parallel" = true;
          "org.gradle.home" = config.programs.java.package;
        };
      };
    };
  };
}
