{ config, lib, ... }:
{
  programs = {
    micro = {
      enable = true;
      settings = {
        autoindent = true;
        autosave = 0;
        autosu = false;
        backup = true;
        backupdir = "${config.xdg.dataHome}/micro/backups";
        basename = false;
        clipboard = "external";
        colorcolumn = 80;
        colorscheme = lib.mkIf (!config.sof.catppuccin.enable) "atom-dark";
      };
    };
  };
}
