{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.darcs = {
    enable = lib.mkEnableOption "Soaffine Darcs Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.darcs.enable {
    programs = {
      darcs = {
        enable = true;
        author = [ "${config.affineUser.name} <${config.affineUser.email}>" ];
      };
    };
  };
}
