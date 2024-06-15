{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.cava = {
    enable = lib.mkEnableOption "Soaffine Cava Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.cava.enable {
    home.packages = builtins.attrValues { inherit (pkgs) cavalier; };
    programs = {
      cava = {
        enable = true;
        settings = {
          general = {
            framerate = 60;
          };
          input = {
            method = "pipewire";
            source = "auto";
          };
          output = {
            # method = "sdl_glsl"; https://github.com/NixOS/nixpkgs/issues/320129
            # method = "sdl";
            alacritty_sync = 1;
          };
        };
      };
    };
  };
}
