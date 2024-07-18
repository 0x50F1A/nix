{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.zsh = {
    enable = lib.mkEnableOption "Soaffine Zsh Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.zsh.enable {
    programs = {
      zsh = {
        enable = true;
        autocd = true;
        autosuggestion = {
          enable = true;
        };
        dotDir = "${config.xdg.configHome}/zsh";
        enableCompletion = true;
        enableVteIntegration = true;
        syntaxHighlighting = {
          enable = true;
        };
      };
    };
  };
}
