{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.python = {
    enable = lib.mkEnableOption "Soaffine Python Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.python.enable {
    warnings = lib.optional (config.sof.python.enable) ''
      Python is enabled system-wide. While this is okay, a better strategy is to leverage devShells per-project.
    '';
    home.packages = builtins.attrValues { inherit (pkgs) poetry2conda pyright; };
    programs = {
      poetry = {
        enable = true;
        package = pkgs.poetry.withPlugins (
          plugins:
          builtins.attrValues {
            inherit (plugins)
              poetry-audit-plugin
              poetry-plugin-export
              poetry-plugin-poeblix
              poetry-plugin-up
              ;
          }
        );
        settings = {
          virtualenvs = {
            create = true;
            in-project = true;
          };
        };
      };
      pyenv = {
        enable = true;
      };
      pylint = {
        enable = true;
      };
      ruff = {
        enable = true;
      };
    };
  };
}
