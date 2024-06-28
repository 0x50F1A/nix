{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.rio = {
    enable = lib.mkEnableOption "Soaffine Rio Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.rio.enable {
    programs = {
      rio = {
        enable = true;
        settings = {
          blinking-cursor = true;
          cursor = "|";
          editor = config.home.sessionVariables.VISUAL or config.home.sessionVariables.EDITOR;
          font = {
            regular = {
              family = builtins.elemAt flake.config.affineUser.theme.defaultFonts.monospace 0;
              weight = 400;
            };
            extras = [
              { family = "MesloLGS NF"; }
              { family = "MesloLGS Nerd Font Mono"; }
              { family = "Fira Code"; }
              { family = "Noto Color Emoji"; }
            ];
          };
          line-height = 1.2;
          keyboard = {
            use-kitty-keyboard-protocol = true;
          };
          renderer = {
            performance = "High";
            backend = "Automatic";
            disable-unfocused-render = false;
          };
          window = {
            opacity = 0.7;
            blur = true;
          };
        };
      };
    };
  };
}
