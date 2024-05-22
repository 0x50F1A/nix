_: {
  programs = {
    starship = {
      enable = true;
      enableNushellIntegration = true;
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
        pijul_channel = {
          disabled = false;
        };
      };
    };
  };
}
