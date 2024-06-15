{
  config,
  lib,
  ...
}: {
  _file = ./default.nix;

  options.sof.boxxy = {
    enable =
      lib.mkEnableOption "Soaffine Boxxy Home Configuration"
      // {
        default = true;
      };
  };

  config = lib.mkIf config.sof.boxxy.enable {
    programs = {
      boxxy = {
        enable = true;
      };
    };
  };
}
