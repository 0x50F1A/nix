{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.fuzzel = {
    enable = lib.mkEnableOption "Soaffine Fuzzel Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.fuzzel.enable {
    programs = {
      fuzzel = {
        enable = true;
        settings = {
          main = {
            terminal = lib.getExe pkgs.wezterm;
            layer = "overlay";
          };
          colors.background = "00000000dd";
        };
      };
    };
  };
}
