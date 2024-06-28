{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.neovim = {
    enable = lib.mkEnableOption "Soaffine Neovim Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.neovim.enable {
    warnings = lib.optional (config.sof.neovim.enable) ''
      Neovim is currently enabled via vanilla home-manager. However, nixvim is likely preferable: https://github.com/nix-community/nixvim
    '';
    programs = {
      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = true;
      };
    };
  };
}
