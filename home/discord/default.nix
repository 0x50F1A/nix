{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.discord = {
    enable = lib.mkEnableOption "Soaffine Discord Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.discord.enable {
    home.packages = builtins.attrValues { inherit (pkgs) betterdiscordctl discord vesktop; };
  };
}
