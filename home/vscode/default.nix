{ config, flake, lib, pkgs, ... }:
let vsce = pkgs.vscode-extensions;
in {
  _file = ./default.nix;

  options.sof.vscode = {
    enable = lib.mkEnableOption "Soaffine VSCode Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.vscode.enable {
    programs = {
      vscode = {
        enable = true;
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;
        mutableExtensionsDir = false;
        extensions = builtins.attrValues {
          inherit (vsce.aaron-bond) better-comments;
          inherit (vsce.alefragnani) bookmarks;
          inherit (vsce.bradlc) vscode-tailwindcss;
          inherit (vsce.catppuccin) catppuccin-vsc;
          inherit (vsce.dbaeumer) vscode-eslint;
          inherit (vsce.eamodio) gitlens;
          inherit (vsce.editorconfig) editorconfig;
          inherit (vsce.equinusocio) vsc-material-theme-icons;
          inherit (vsce.github)
            copilot copilot-chat vscode-github-actions
            vscode-pull-request-github;
          inherit (vsce.golang) go;
          inherit (vsce.gruntfuggly) todo-tree;
          inherit (vsce.hbenl) vscode-test-explorer;
          inherit (vsce.jnoortheen) nix-ide;
          inherit (vsce.justusadam) language-haskell;
          inherit (vsce.mikestead) dotenv;
          inherit (vsce.ms-azuretools) vscode-docker;
          inherit (vsce.ms-python) debugpy python vscode-pylance;
          inherit (vsce.ms-vscode-remote) remote-containers remote-ssh;
          inherit (vsce.ms-vscode) cpptools test-adapter-converter;
          inherit (vsce.mkhl) direnv;
          inherit (vsce.oderwat) indent-rainbow;
          inherit (vsce.redhat) vscode-yaml;
          inherit (vsce.rust-lang) rust-analyzer;
          inherit (vsce.serayuzgur) crates;
          inherit (vsce.streetsidesoftware) code-spell-checker;
          inherit (vsce.thenuprojectcontributors) vscode-nushell-lang;
          inherit (vsce.tomoki1207) pdf;
          inherit (vsce.usernamehw) errorlens;
          inherit (vsce.vadimcn) vscode-lldb;
          inherit (vsce.yoavbls) pretty-ts-errors;
          inherit (vsce.yzhang) markdown-all-in-one;
        } ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            publisher = "dustypomerleau";
            name = "rust-syntax";
            version = "0.6.1";
            sha256 = "sha256-o9iXPhwkimxoJc1dLdaJ8nByLIaJSpGX/nKELC26jGU=";
          }
          {
            publisher = "JScearcy";
            name = "rust-doc-viewer";
            version = "4.2.0";
            sha256 = "sha256-x1pmrw8wYHWyNIJqVdoh+vasbHDG/A4m8vDZU0DnPzo=";
          }
          {
            publisher = "magicstack";
            name = "edgedb";
            version = "0.1.7";
            sha256 = "sha256-poW1BhurhHZRS+FVSOL6PRl95wdHqux3kzbTvs5Q9Ik=";
          }
          {
            publisher = "swellaby";
            name = "vscode-rust-test-adapter";
            version = "0.11.0";
            sha256 = "sha256-IgfcIRF54JXm9l2vVjf7lFJOVSI0CDgDjQT+Hw6FO4Q=";
          }
          {
            publisher = "vsls-contrib";
            name = "gistfs";
            version = "0.6.0";
            sha256 = "sha256-3BWY1VxMIzAjChWYIDbdx7YAP/4MH//NbjlLAkjTMb8=";
          }
          {
            publisher = "vsls-contrib";
            name = "gitdoc";
            version = "0.1.0";
            sha256 = "sha256-XjYPr5CBxIwnNBffKXrFD0/jTOXB42ebfgZiljWPZWk=";
          }
        ];
        userSettings = {
          editor = {
            codeActionsOnSave = {
              source = { fixAll = { eslint = "explicit"; }; };
            };
            formatOnPaste = true;
            formatOnSave = true;
            fontFamily = lib.concatMapStringsSep ", " (s: "'${s}'")
              (flake.config.affineUser.theme.defaultFonts.monospace
                ++ [ "Material Design Icons" ]);
            fontSize = flake.config.affineUser.theme.terminal.fontSize;
            guides = { indentation = false; };
            hover = { delay = 700; };
            renderWhitespace = "all";
            rulers = [ 80 120 ];
            smoothScrolling = true;
            tabSize = 2;
          };
          eslint = {
            validate =
              [ "javascript" "javascriptreact" "typescript" "typescriptreact" ];
          };
          explorer = {
            fileNesting = {
              enabled = true;
              patterns = {
                "*.ts" = "\${capture}.js, \${capture}.typegen.ts";
                "*.js" =
                  "\${capture}.js.map, \${capture}.min.js, \${capture}.d.ts";
                "*.jsx" = "\${capture}.js";
                "*.tsx" = "\${capture}.ts, \${capture}.typegen.ts";
                "tsconfig.json" = "tsconfig.*.json";
                "package.json" = "package-lock.json, yarn.lock, pnpm-lock.yaml";
                "*.mts" = "\${capture}.typegen.ts";
                "*.cts" = "\${capture}.typegen.ts";
              };
            };
          };
          files = {
            autoSave = "afterDelay";
            associations = { ".env*" = "dotenv"; };
            insertFinalNewline = true;
            trimTrailingWhitespace = true;
          };
          github = {
            copilot = {
              advanced = { };
              enable = {
                "*" = true;
                plaintext = false;
                markdown = false;
                scminput = false;
              };
            };
          };
          indentRainbow = {
            colors = let
              count = 12;
              saturation = 0.425;
              lightness = 0.35;
              alpha = 0.5;
            in map (hue:
              "hsla(${
                lib.concatStringsSep "," [
                  (toString hue)
                  (flake.inputs.bird-nix-lib.lib.toPercent 1 saturation)
                  (flake.inputs.bird-nix-lib.lib.toPercent 1 lightness)
                  (toString alpha)
                ]
              })") (lib.genList (i: (360 / count) * i) count);
          };
          nix = {
            # This makes nix formatting always work. It's an open question whether we should do this for other servers..
            enableLanguageServer = true;
            serverPath = lib.getExe pkgs.nil;
            serverSettings = {
              nil = {
                formatting = {
                  command = [ (lib.getExe pkgs.nixfmt-rfc-style) ];
                };
              };
            };
          };
          terminal = {
            integrated = {
              gpuAcceleration = "on";
              smoothScrolling = true;
              shellIntegration = { enabled = true; };
            };
          };
          workbench = {
            colorTheme = "Catppuccin Mocha";
            iconTheme = "material-icon-theme";
          };
          update = { mode = "none"; };
          "[python]"."editor.formatOnType" = true;
          "typescript.updateImportsOnFileMove.enabled" = "always";
          "javascript.updateImportsOnFileMove.enabled" = "always";
        };
      };
    };
  };
}
