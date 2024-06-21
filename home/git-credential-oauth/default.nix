{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.git-credential-oauth = {
    enable = lib.mkEnableOption "Soaffine Git Credential OAuth Helper Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.git-credential-oauth.enable {
    programs = {
      git-credential-oauth = {
        enable = true;
      };
    };
  };
}
