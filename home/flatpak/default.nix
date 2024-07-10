{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;
  imports = [ flake.inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  options.sof.flatpak = {
    enable = lib.mkEnableOption "Soaffine Flatpak Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.flatpak.enable {
    services.flatpak = {
      remotes = [
        {
          name = "kdeapps";
          location = "https://distribute.kde.org/kdeapps.flatpakrepo";
        }
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];
      packages = [ ];
      update.auto = {
        enable = true;
      };
      overrides = {
        global = {
          Context.sockets = [
            "wayland"
            "!x11"
            "!fallback-x11"
          ];
          Environment = {
            XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
          };
        };
      };
    };
  };
}
