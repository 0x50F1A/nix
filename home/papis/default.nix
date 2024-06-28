{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.papis = {
    enable = lib.mkEnableOption "Soaffine Papis Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.papis.enable {
    programs = {
      papis = {
        enable = true;
        libraries = {
          "${flake.config.affineUser.name}" = {
            isDefault = true;
            settings = {
              dir = "${config.xdg.userDirs.documents}/papis";
            };
          };
        };
        settings = {
          editor = config.home.sessionVariables.VISUAL or config.home.sessionVariables.EDITOR;
          file-browser = config.home.sessionVariables.FILE_BROWSER;
          add-edit = true;
        };
      };
    };
  };
}
