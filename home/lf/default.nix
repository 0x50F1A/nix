{
  config,
  lib,
  pkgs,
  ...
}:
let
  iconsfile = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/gokcehan/lf/b47cf6d5a525c39db268c2f7b77e2b7497843b17/etc/icons.example";
    sha256 = "04jnldz0y2fj4ymypzmvs7jjbvvjrwzdp99qp9r12syfk65nh9cn";
  };
in
{
  _file = ./default.nix;

  options.sof.lf = {
    enable = lib.mkEnableOption "Soaffine List Files (lf) Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.lf.enable {
    home.file."${config.xdg.configHome}/lf/icons".source = iconsfile;
    programs = {
      lf = {
        enable = true;
        keybindings = {
          gs = "fzf_search";
        };
        previewer = {
          keybinding = "i";
          source = lib.getExe pkgs.ctpv;
        };
        settings = {
          drawbox = true;
          dirfirst = true;
          icons = true;
          ignorecase = true;
          preview = true;
          shell = lib.getExe pkgs.dash;
          shellopts = "-eu";
          tabstop = 2;
          info = "size";
        };
        extraConfig = ''
          &${lib.getExe pkgs.ctpv} -s $id
          cmd on-quit %${lib.getExe pkgs.ctpv} -e $id
          set cleaner ${lib.getExe' pkgs.ctpv "ctpvclear"}
        '';
      };
    };
  };
}
