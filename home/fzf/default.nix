{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.fzf = {
    enable = lib.mkEnableOption "Soaffine Fzf Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.fzf.enable {
    programs = {
      fzf = {
        enable = true;
        colors = lib.mkIf (!config.sof.catppuccin.enable) {
          fg = "#cbccc6";
          bg = "#1f2430";
          hl = "#707a8c";
          "fg+" = "#707a8c";
          "bg+" = "#191e2a";
          "hl+" = "#ffcc66";
          info = "#73d0ff";
          prompt = "#707a8c";
          pointer = "#cbccc6";
          marker = "#73d0ff";
          spinner = "#73d0ff";
          header = "#d4bfff";
        };
        defaultCommand = "fd --type f";
        defaultOptions = [
          "--preview 'bat --color=always {}' --preview-window '~3'"
          "--border"
        ];
        fileWidgetOptions = [ "--preview 'head {}'" ];
        historyWidgetOptions = [
          "--sort"
          "--exact"
        ];
        tmux = {
          enableShellIntegration = true;
        };
      };
    };
  };
}
