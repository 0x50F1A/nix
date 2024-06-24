{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.helix = {
    enable = lib.mkEnableOption "Soaffine Helix Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.helix.enable {
    programs = {
      helix = {
        enable = true;
        defaultEditor = true;
        languages = {
          language = [
            {
              name = "nix";
              language-servers = [ "nil" ];
              roots = [
                "flake.nix"
                "flake.json"
              ];
              scope = "source.nix";
              auto-format = true;
              formatter = {
                command = "${lib.getExe pkgs.nixfmt-rfc-style}";
              };
            }
            {
              name = "rust";
              auto-format = true;
            }
          ];
          language-server.rust-analyzer = {
            config.check.command = "clippy";
          };
        };
        settings = {
          editor = {
            line-number = "relative";
            auto-completion = true;
            auto-format = true;
            auto-save = true;
            color-modes = true;
            statusline = {
              left = [
                "mode"
                "spacer"
                "version-control"
                "position"
                "spinner"
              ];
              center = [
                "file-name"
                "separator"
                "file-modification-indicator"
              ];
              right = [
                "diagnostics"
                "separator"
                "workspace-diagnostics"
                "selections"
                "primary-selection-length"
                "separator"
                "file-encoding"
                "file-type"
              ];
              separator = "φ";
            };
            theme = lib.mkIf (!config.sof.catppuccin.enable) "catppuccin_mocha";
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
  };
}
