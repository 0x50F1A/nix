{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.htop = {
    enable = lib.mkEnableOption "Soaffine hTop Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.htop.enable {
    programs = {
      htop = {
        enable = true;
        package = pkgs.htop-vim;
      };
    };
  };
}
