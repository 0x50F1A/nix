{ config, lib, ... }:
{
  _file = ./default.nix;
  options.sof.lix = {
    enable = lib.mkEnableOption "Soaffine Lix Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.lix.enable {
    nix.settings.substituters = [ "https://cache.lix.systems" ];

    nix.settings.trusted-public-keys = [
      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
    ];
  };
}
