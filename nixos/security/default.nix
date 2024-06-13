{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;
  options.sof.security = {
    enable = lib.mkEnableOption "Soaffine Security Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.security.enable {
    security = {
      doas = {
        enable = true;
        extraRules = [
          {
            users = [ flake.config.people.myself ];
            keepEnv = true;
            noPass = true;
          }
        ];
        wheelNeedsPassword = false;
      };
      sudo = {
        enable = false;
        wheelNeedsPassword = false;
      };
      sudo-rs = {
        enable = true;
        wheelNeedsPassword = false;
        execWheelOnly = true;
      };
      polkit = {
        enable = true;
      };
    };
  };
}
