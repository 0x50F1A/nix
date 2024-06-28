{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.nnn;
  shellAliases = {
    n = "${lib.getExe cfg.package} -a";
    nnn = "${lib.getExe cfg.package} -a";
  };
in
{
  _file = ./default.nix;

  options.sof.nnn = {
    enable = lib.mkEnableOption "Soaffine Nnn Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.nnn.enable {
    programs = {
      nnn = {
        enable = true;
        package = pkgs.nnn.override ({ withEmojis = true; });
        extraPackages = builtins.attrValues {
          inherit (pkgs)
            bat
            ffmpeg
            ffmpegthumbnailer
            file
            fontpreview
            imagemagick
            man
            mediainfo
            pistol
            sxiv
            unzip
            viu
            w3m
            ;
        };
        plugins = {
          src = "${pkgs.nnn.src}/plugins";
          mappings = {
            p = "preview-tui";
          };
        };
      };
      bash = {
        inherit shellAliases;
      };
      fish = {
        inherit shellAliases;
      };
      zsh = {
        inherit shellAliases;
      };
      nushell = {
        inherit shellAliases;
      };
    };

    home.sessionVariables = {
      NNN_PREVIEWDIR = "${config.xdg.cacheHome}/nnn/previews";
    };
  };
}
