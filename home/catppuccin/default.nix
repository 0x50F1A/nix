{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.catppuccin = {
    enable = lib.mkEnableOption "Soaffine Catppuccin Theme Home Configuration" // {
      default = true;
    };
  };

  config =
    let
      accent = flake.config.affineUser.theme.catppuccinAccent;
      flavor = flake.config.affineUser.theme.catppuccinFlavor;
    in
    lib.mkIf config.sof.catppuccin.enable {
      catppuccin = {
        inherit accent flavor;
        enable = lib.mkDefault true;
        pointerCursor = {
          inherit accent flavor;
          enable = true;
        };
      };
      programs = {
        alacritty = {
          catppuccin.enable = true;
        };
        bat = {
          catppuccin.enable = true;
        };
        bottom = {
          catppuccin.enable = true;
        };
        cava = {
          catppuccin.enable = true;
        };
        fish = {
          catppuccin.enable = true;
        };
        foot = {
          catppuccin.enable = true;
        };
        fzf = {
          catppuccin.enable = true;
        };
        gh-dash = {
          catppuccin.enable = true;
        };
        git = {
          delta = {
            catppuccin.enable = true;
          };
        };
        gitui = {
          catppuccin.enable = true;
        };
        glamour = {
          catppuccin.enable = true;
        };
        helix = {
          catppuccin.enable = true;
        };
        k9s = {
          catppuccin.enable = true;
        };
        kitty = {
          catppuccin.enable = true;
        };
        lazygit = {
          catppuccin.enable = true;
        };
        micro = {
          catppuccin.enable = true;
        };
        mpv = {
          catppuccin.enable = true;
        };
        neovim = {
          catppuccin.enable = true;
        };
        rio = {
          catppuccin.enable = true;
        };
        rofi = {
          catppuccin.enable = true;
        };
        starship = {
          catppuccin.enable = true;
        };
        yazi = {
          catppuccin.enable = true;
        };
        zathura = {
          catppuccin.enable = true;
        };
        zellij = {
          catppuccin.enable = true;
        };
        zsh = {
          syntaxHighlighting = {
            catppuccin.enable = true;
          };
        };
      };
      gtk = {
        catppuccin = {
          inherit accent flavor;
          enable = true;
          icon = {
            inherit accent flavor;
            enable = true;
          };
        };
      };
      qt = {
        style = {
          catppuccin = {
            enable = true;
          };
        };
      };
      services = {
        dunst = {
          catppuccin = {
            enable = true;
          };
        };
        mako = {
          catppuccin = {
            enable = true;
          };
        };
      };
    };
}
