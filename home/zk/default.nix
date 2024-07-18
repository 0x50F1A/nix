{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.zk = {
    enable = lib.mkEnableOption "Soaffine Zk Home Configuration" // {
      default = true;
    };
    notebookDir = lib.mkOption {
      type = lib.types.str;
      description = "Directory for ZK notebook";
      default = config.xdg.userDirs.documents + "/zk";
    };
  };

  config = lib.mkIf config.sof.zk.enable {
    home.sessionVariables = {
      "ZK_NOTEBOOK_DIR" = config.sof.zk.notebookDir;
    };

    programs = {
      zk = {
        enable = true;
        settings = {
          note = {
            language = "en";
            default-title = "Untitled";
            filename = "{{id}}-{{slug title}}";
            extension = "md";
            template = "default.md";
            id-charset = "hex";
            id-length = 8;
            id-case = "lower";
          };
          notebook = {
            dir = config.sof.zk.notebookDir;
          };
          tool = {
            editor = config.home.sessionVariables.EDITOR;
            fzf-preview = "bat -p --color always {-1}";
          };
          extra = {
            author = flake.config.affineUser.name;
          };
        };
      };
    };
  };
}
