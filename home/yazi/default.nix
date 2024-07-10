{
  config,
  lib,
  pkgs,
  ...
}:
let
  archiveMimeTypes = [
    "application/*zip"
    "application/x-tar"
    "application/x-bzip2"
    "application/x-7z-compressed"
    "application/x-rar"
    "application/x-xz"
  ];
  yazi-plugins = import ./nix/sources.nix;
  pluginList = [
    "exifaudio"
    "eza-preview"
    "fg"
    "glow"
    "hexyl"
    "miller"
    "ouch"
    "torrent-preview"
  ];
in
{
  _file = ./default.nix;

  options.sof.yazi = {
    enable = lib.mkEnableOption "Soaffine Yazi Home Configuration" // {
      default = true;
    };
    enableEza = lib.mkEnableOption "Eza Plugin" // {
      default = false;
    };
    enableOuch = lib.mkEnableOption "Ouch Plugin" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.yazi.enable {
    programs = {
      yazi = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableNushellIntegration = true;
        enableZshIntegration = true;
        keymap = {
          manager.prepend_keymap = [
            {
              on = [
                "f"
                "g"
              ];
              run = "plugin fg";
              desc = "find file by content";
            }
            {
              on = [
                "f"
                "f"
              ];
              run = "plugin fg --args='fzf'";
              desc = "find file by file name";
            }
            {
              on = [ "<C-s>" ];
              run = ''shell "$SHELL" --block --confirm'';
              desc = "Open shell here";
            }
          ];
        };
        plugins =
          builtins.listToAttrs (
            map (name: {
              inherit name;
              value = yazi-plugins."${name}.yazi".outPath;
            }) pluginList
          )
          // {
            bat = yazi-plugins.yazi-plugin-bat.outPath;
          };
        settings = lib.mkMerge [
          {
            manager = {
              ratio = [
                1
                3
                4
              ];
              sort_by = "natural";
              sort_dir_first = true;
              show_hidden = true;
              show_symlink = true;
              linemode = "size";
            };
            opener = {
              play = [
                {
                  run = ''${lib.getExe pkgs.mpv} "$@"'';
                  orphan = true;
                  for = "unix";
                }
              ];
            };
            plugin = {
              prepend_previewers = [
                {
                  mime = "text/*";
                  run = "bat";
                }
                {
                  mime = "audio/*";
                  run = "exifaudio";
                }
                {
                  name = "*.md";
                  run = "glow";
                }
                {
                  name = "*.hex";
                  run = "hexyl";
                }
                {
                  name = "text/csv";
                  run = "miller";
                }
                {
                  mime = "application/x-bittorrent";
                  run = "torrent-preview";
                }
              ];
            };
          }
          {
            plugins.prepend_previewers = lib.mkIf config.sof.yazi.enableEza [
              {
                mime = "*/";
                run = "eza-preview";
              }
            ];
          }
          (lib.mkIf config.sof.yazi.enableOuch {
            plugin.prepend_previewers = lib.mkBefore (
              map (mime: {
                inherit mime;
                run = "ouch";
              }) archiveMimeTypes
            );
          })
        ];
      };
    };
    home = {
      sessionVariables.FILE_BROWSER = lib.getExe pkgs.yazi;
      packages = lib.mkMerge [
        (lib.mkIf config.sof.yazi.enableOuch [ pkgs.ouch ])
        (lib.mkIf config.sof.yazi.enableEza [ pkgs.eza ])
        (builtins.attrValues {
          inherit (pkgs)
            exiftool
            glow
            hexyl
            miller
            transmission_4
            ;
        })
      ];
    };
  };
}
