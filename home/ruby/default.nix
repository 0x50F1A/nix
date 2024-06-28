{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.ruby = {
    enable = lib.mkEnableOption "Soaffine Ruby Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.ruby.enable {
    warnings = lib.optional (config.sof.ruby.enable) ''
      Ruby is enabled system-wide. While this is okay, a better strategy is to leverage devShells per-project.
    '';
    programs = {
      rbenv = {
        enable = true;
      };
    };
  };
}
