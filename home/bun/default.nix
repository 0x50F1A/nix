{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.bun = {
    enable = lib.mkEnableOption "Soaffine Bun Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.bun.enable {
    warnings = lib.optional (config.sof.bun.enable) ''
      Bun is enabled system-wide. While this is okay, a better strategy is to leverage devShells per-project.
    '';

    programs = {
      bun = {
        enable = true;
        enableGitIntegration = true;
        settings = {
          smol = false;
          telemetry = false;
          install = {
            exact = true;
            frozenLockfile = true;
          };
          run = {
            shell = "zsh";
            bun = true;
          };
        };
      };
    };
  };
}
