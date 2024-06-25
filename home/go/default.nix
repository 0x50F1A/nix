{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.go = {
    enable = lib.mkEnableOption "Soaffine Golang Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.go.enable {
    warnings = lib.optional (config.sof.go.enable) ''
      Golang is enabled system-wide. While this is okay, a better strategy is to leverage devShells per-project.
    '';
    programs = {
      go = {
        enable = true;
      };
    };
  };
}
