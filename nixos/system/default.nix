{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.system = {
    enable = lib.mkEnableOption "Soaffine NixOS System Configuration" // {
      default = true;
    };

    showSystemDiffOnRebuild = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = true;
      description = lib.mdDoc "Whether to enable diffing the system against the currently activated one on a NixOS system activation";
    };

    showNvdSystemDiffOnRebuild = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = lib.mdDoc "Whether to enable nvd diffing the system against the currently activated one on a NixOS system activation";
    };
  };

  config = lib.mkIf config.sof.system.enable {
    system = {
      activationScripts = {
        diff-closures = lib.mkIf config.sof.system.showSystemDiffOnRebuild {
          supportsDryActivation = true;
          text = ''
            if [[ -e /run/current-system ]]; then
              ${config.nix.package}/bin/nix --extra-experimental-features 'nix-command' store diff-closures /run/current-system "$systemConfig" || true 
            fi
          '';
        };
        nvd = lib.mkIf config.sof.system.showNvdSystemDiffOnRebuild {
          supportsDryActivation = true;
          text = ''
            if [[ -e /run/current-system ]]; then
              ${lib.getExe pkgs.nvd} --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig" || true
            fi
          '';
        };
      };
    };
  };
}
