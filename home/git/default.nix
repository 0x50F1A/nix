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
    warnings = lib.optional (config.sof.git.enable) ''
      Git signing currently uses a hard coded public key 
    '';
    home.file.".ssh/allowed_signers".text = ''
      * ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILrN+tLxImC5Y6jGjSkhf2lGVUWp3m00r+7kM/eZA0ON sofia
      * ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKjutIbvUj3CCDe18HkvtS14xvlJh3YBvPpdEAFmTYlq sofia
    '';
    programs = {
      git = {
        enable = true;
        package = pkgs.gitFull;
        delta = {
          enable = true;
          options = {
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
        userEmail = flake.config.affineUser.email;
        extraConfig = {
          commit = {
            gpgsign = true;
            verbose = true;
          };
          diff = {
            colorMoved = "default";
          };
          gpg = {
            format = "ssh";
            ssh = {
              allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
            };
          };
          merge = {
            conflictstyle = "diff3";
          };
          pull = {
            rebase = true;
          };
          rerere = {
            enabled = true;
          };
          url = {
            "git@github.com:".pushinsteadof = "https://github.com";
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
        git-branchless
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
