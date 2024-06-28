{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.home-manager = {
    enable = lib.mkEnableOption "Soaffine Home Manager Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.home-manager.enable {
    home = {
      enableDebugInfo = true;
      enableNixpkgsReleaseCheck = true;
      stateVersion = "24.05";
      activation = {
        nvd = config.lib.dag.entryAnywhere ''
          ${lib.getExe pkgs.nvd} diff $oldGenPath $newGenPath
        '';
      };
    };
    manual = {
      manpages.enable = true;
      html.enable = true;
      json.enable = true;
    };
    programs.home-manager.enable = true;
  };
}
