{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.gh = {
    enable = lib.mkEnableOption "Soaffine Github CLI Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.gh.enable {
    programs = {
      gh = {
        enable = true;
        extensions = builtins.attrValues {
          inherit (pkgs)
            gh-actions-cache
            gh-copilot
            gh-eco
            gh-f
            gh-markdown-preview
            gh-notify
            gh-poi
            gh-s
            ;
        };
        settings = {
          git_protocol = "ssh";

          prompt = "enabled";
        };
      };
      gh-dash = {
        enable = true;
      };
    };
    home.packages = builtins.attrValues { inherit (pkgs) github-desktop; };
  };
}
