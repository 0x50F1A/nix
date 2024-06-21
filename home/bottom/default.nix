{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.bottom = {
    enable = lib.mkEnableOption "Soaffine Bottom Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.bottom.enable {
    programs = {
      bottom = {
        enable = true;
        settings = {
          flags = {
            avg_cpu = true;
            enable_gpu = true;
            network_use_binary_prefix = true;
            network_use_bytes = true;
            network_use_log = true;
            temperature_type = "c";
          };
        };
      };
    };
  };
}
