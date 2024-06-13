{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;
  options.sof.nix-ld = {
    enable = lib.mkEnableOption "Soaffine Nix-ld Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.nix-ld.enable {
    programs.nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
  };
}
