{
  config,
  lib,
  pkgs,
  ...
}: {
  _file = ./default.nix;

  options.sof.aws = {
    enable =
      lib.mkEnableOption "Soaffine AWS Home Configuration"
      // {
        default = true;
      };
  };

  config =
    lib.mkIf config.sof.aws.enable {
      home.packages = builtins.attrValues {
        inherit
          (pkgs)
          awsbck
          awsls
          awsume
          cw
          e1s
          pacu
          rain
          ssmsh
          yatas
          ;
      };

      programs = {
        awscli = {
          enable = true;
        };
      };

      # aws-cli does not work well with xdg base directories
      # https://github.com/aws/aws-sdk/issues/30#issuecomment-532208981
      home.sessionVariables = {
        AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";
        AWS_CLI_HISTORY_FILE = "${config.xdg.dataHome}/aws/history";
        AWS_CREDENTIALS_FILE = "${config.xdg.dataHome}/aws/credentials";
        AWS_SHARED_CREDENTIALS_FILE = "${config.xdg.dataHome}/aws/shared-credentials";
        AWS_WEB_IDENTITY_TOKEN_FILE = "${config.xdg.dataHome}/aws/token";
      };
    }
    // lib.mkIf config.sof.boxxy.enable {
      programs.boxxy = lib.mkIf config.sof.boxxy.enable {
        rules = {
          name = "redirect aws-cli from ~/.aws to ${config.xdg.configHome}/aws";
          target = "~/.aws";
          rewrite = "${config.xdg.configHome}/aws";
        };
      };

      home.shellAliases = {
        aws = "boxxy aws";
      };
    };
}
