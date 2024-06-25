{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.gradle = {
    enable = lib.mkEnableOption "Soaffine Gradle Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.gradle.enable {
    programs = {
      gradle = {
        enable = true;
        mutableKeys = false;
        mutableTrust = false;
      };
    };
  };
}
