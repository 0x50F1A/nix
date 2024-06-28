{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.jujutsu = {
    enable = lib.mkEnableOption "Soaffine Jujutsu Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.jujutsu.enable {
    programs = {
      jujutsu = {
        enable = true;
        settings = {
          core = {
            fsmonitor = "watchman";
            watchman.register_snapshot_trigger = true;
          };
          merge-tools = {
            delta = {
              program = lib.getExe pkgs.delta;
              diff-args = [
                "$left"
                "$right"
              ];
            };
            diffedit3 = {
              program = lib.getExe pkgs.diffedit3;
              edit-args = [
                "$left"
                "$right"
                "$output"
              ];
            };
            difftastic = {
              program = lib.getExe pkgs.difftastic;
              diff-args = [
                "--color=always"
                "$left"
                "$right"
              ];
            };
          };
          signing = {
            sign-all = config.programs.git.extraConfig.commit.gpgsign;
            backend = config.programs.git.extraConfig.gpg.format;
            backends.ssh.allowed-signers = config.programs.git.extraConfig.gpg.ssh.allowedSignersFile;
            key = config.programs.git.extraConfig.user.signingkey;
          };
          ui = {
            diff = {
              format = "git";
              tool = "difftastic";
            };
            diff-editor = "diffedit3";
            editor = config.home.sessionVariables.VISUAL;
            merge-editor = "vscode";
            pager = "delta";
          };
          user = {
            inherit (flake.config.affineUser) name email;
          };
        };
      };
    };

    home.packages = builtins.attrValues {
      inherit (flake.inputs.jj_tui.packages.${pkgs.system}) default;
      inherit (pkgs) watchman; # lazyjj;
    };
  };
}
