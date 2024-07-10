{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.starship = {
    enable = lib.mkEnableOption "Soaffine Starship Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.starship.enable {
    programs = {
      starship = {
        enable = true;
        settings = {
          add_newline = true;
          format = "$all";
          character = {
            success_symbol = "[λ](bold green) ";
            error_symbol = "[⊥](bold red) ";
          };
          cmd_duration = {
            show_milliseconds = true;
            format = "⊨ [$duration](italic cyan)";
          };
          container = {
            disabled = true;
          };
          direnv = {
            disabled = false;
          };
          fossil_branch = {
            disabled = false;
          };
          fossil_metrics = {
            disabled = false;
          };
          hg_branch = {
            disabled = false;
          };
          pijul_channel = {
            disabled = false;
          };
        };
      };
    };
  };
}
