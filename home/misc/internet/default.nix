{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.misc.internet = {
    enable = lib.mkEnableOption "Soaffine Internet Miscellaneous Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.misc.internet.enable {
    home.packages = builtins.attrValues { inherit (pkgs) rclone speedtest-cli qbittorrent; };
  };
}
