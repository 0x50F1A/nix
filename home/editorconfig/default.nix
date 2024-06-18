{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.editorconfig = {
    enable = lib.mkEnableOption "Soaffine EditorConfig Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.editorconfig.enable {
    warnings = lib.optional (config.sof.editorconfig.enable) ''
      EditorConfig is enabled system-wide. While this is okay, a better strategy is to leverage devShells per-project.
    '';
    editorconfig = {
      enable = true;
      settings = {
        "*" = {
          charset = "utf-8";
          end_of_line = "lf";
          trim_trailing_whitespace = true;
          insert_final_newline = true;
          indent_style = "tab";
          indent_size = 4;
        };
      };
    };
  };
}
