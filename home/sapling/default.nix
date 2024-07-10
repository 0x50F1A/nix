{ config, flake, lib, ... }: {
  _file = ./default.nix;

  options.sof.sapling = {
    enable = lib.mkEnableOption "Soaffine Sapling Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.sapling.enable {
    warnings = lib.optional (config.sof.sapling.enable) ''
      Sapling is disabled for not building as of 2024-07-09
    '';
    programs = {
      sapling = {
        enable = false;
        userName = flake.config.affineUser.name;
        userEmail = flake.config.affineUser.email;
      };
    };
  };
}
