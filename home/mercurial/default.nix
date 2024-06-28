{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.mercurial = {
    enable = lib.mkEnableOption "Soaffine Mercurial Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.mercurial.enable {
    programs = {
      mercurial = {
        enable = true;
        userName = flake.config.affineUser.name;
        userEmail = flake.config.affineUser.email;
      };
    };
  };
}
