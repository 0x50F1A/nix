{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.tex = {
    enable = lib.mkEnableOption "Soaffine TeX Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.tex.enable {
    programs = {
      texlive = {
        enable = true;
        extraPackages = tpkgs: { inherit (tpkgs) collection-basic collection-fontsrecommended algorithms; };
      };
    };
  };
}
