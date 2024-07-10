{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.sql = {
    enable = lib.mkEnableOption "Soaffine SQL Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.sql.enable {
    warnings = lib.optional (config.sof.sql.enable) ''
      SQL is enabled system-wide. While this is okay, a better strategy is to leverage devShells per-project.
    '';
    home.packages = builtins.attrValues { inherit (pkgs) sqlc sqqldiff sqlfluff sqlmc; };
    programs = {
      sqls = {
        enable = true;
        settings = {
          lowercaseKeywords = false;

        };
      };
    };
  };
}
