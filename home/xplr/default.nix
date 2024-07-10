{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.xplr = {
    enable = lib.mkEnableOption "Soaffine Xplr Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.xplr.enable {
    programs = {
      xplr = {
        enable = true;
        extraConfig = ''
          require("fzf").setup{
            mode = "default",
            key = "ctrl-f",
            bin = "${lib.getExe pkgs.fzf}",
            args = "--preview 'pistol {}'",
            recursive = false,
            enter_dir = false,
          }

          require("ouch").setup{
            mode = "action",
            key = "o",
          }
        '';
        plugins = {
          fzf = pkgs.fetchFromGitHub {
            owner = "sayanarijit";
            repo = "fzf.xplr";
            rev = "f70b267e90ee2c6b210b5b476ec19ea29b220214";
            hash = "sha256-FVaM1u9X1jfE/LLu5+emmD0MfZqpsein4LBmVbahYAk=";
          };
          ouch = pkgs.fetchFromGitHub {
            owner = "dtomvan";
            repo = "ouch.xplr";
            rev = "375edf19ff3e0286bd7a101b9e4dd24fa5abaeb8";
            hash = "sha256-YGFQKzIYIlL+UW2Nel2Tw7WC3MESaVbWYlpj5o2FfLs=";
          };
        };
      };
    };

    home.packages = builtins.attrValues { inherit (pkgs) ouch; };
  };
}
