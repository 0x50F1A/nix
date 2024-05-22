_: {
  programs = {
    helix = {
      enable = true;
      defaultEditor = true;
      languages = {
        language = [
          {
            name = "nix";
            language-servers = ["nil"];
            roots = ["flake.nix" "flake.json"];
            scope = "source.nix";
            auto-format = true;
            formatter = {
              command = "alejandra";
            };
          }
        ];
      };
      settings = {
        theme = "catppuccin_mocha";
        editor = {
          line-number = "relative";
          auto-completion = true;
          auto-format = true;
          auto-save = true;
          color-modes = true;
          statusline = {
            left = ["mode" "spacer" "version-control" "position" "spinner"];
            center = ["file-name" "separator" "file-modification-indicator"];
            right = ["diagnostics" "separator" "workspace-diagnostics" "selections" "primary-selection-length" "separator" "file-encoding" "file-type"];
            separator = "φ";
          };
          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
          file-picker = {
            hidden = false;
            parents = false;
            ignore = false;
            git-ignore = false;
            git-global = false;
            git-exclude = false;
          };
          whitespace = {
            render = "none";
            characters = {
              space = "·";
              tab = "→";
              tabpad = "→";
              newline = "⏎";
            };
          };
          indent-guides = {
            render = true;
          };
        };
      };
    };
  };
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };
}
