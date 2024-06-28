{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.pandoc = {
    enable = lib.mkEnableOption "Soaffine Pandoc Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.pandoc.enable {
    programs = {
      pandoc = {
        enable = true;
        defaults = {
          metadata = {
            author = flake.config.affineUser.name;
          };
          pdf-engine = "lualatex";
        };
      };
    };
  };
}
