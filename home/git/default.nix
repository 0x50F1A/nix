{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.git = {
    enable = lib.mkEnableOption "Soaffine Git Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.git.enable {
    warnings = lib.optional (config.sof.nushell.enable) ''
      Git signing currently uses a hard coded public key 
    '';
    home.file.".ssh/allowed_signers".text = "* ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILrN+tLxImC5Y6jGjSkhf2lGVUWp3m00r+7kM/eZA0ON sofia";
    programs = {
      git = {
        enable = true;
        delta = {
          enable = true;
          options = {
            features = "decorations";
            decorations = {
              commit-decoration-style = "bold cyan box ul";
            };
            hyperlinks = true;
            hyperlinks-file-link-format = "vscode://file/{path}:{line}";
            line-numbers = true;
            side-by-side = true;
            syntax-theme = "Sublime Snazzy";
          };
        };
        lfs = {
          enable = true;
        };
        # signing = {
        #   gpgPath = lib.getExe pkgs.gnupg;
        #   key = null;
        #   signByDefault = true;
        # };
        userName = flake.config.affineUser.name;
        userEmail = "128620044+0x50F1A@users.noreply.github.com";
        extraConfig = {
          commit = {
            gpgsign = true;
          };
          diff = {
            colorMoved = "default";
          };
          merge = {
            conflictstyle = "diff3";
          };
          gpg = {
            format = "ssh";
            ssh = {
              allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
            };
          };
          user = {
            signingkey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
          };
        };
      };
    };
    home.packages = builtins.attrValues {
      inherit (pkgs)
        difftastic
        git-absorb
        git-hound
        git-ps-rs
        gitoxide
        gitsign
        gittuf
        gitu
        ;
    };
  };
}
