{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;
  options.sof.printing = {
    enable = lib.mkEnableOption "Soaffine Printing Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.printing.enable {
    services.printing.enable = true;
    services.printing.drivers = [ pkgs.gutenprint ];
  };
}
