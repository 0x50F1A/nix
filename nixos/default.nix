{
  flake = {
    nixosModules = {
      default.imports = [
        ./boot.nix
        ./nix.nix
        ./user.nix
      ];
      base.imports = [
        ./environment.nix
        ./locale.nix
        ./networking.nix
        ./nix-ld.nix
        ./security.nix
        ./services.nix
        ./smart.nix
        ./system.nix
        ./virtualization.nix
      ];
      commandline.imports = [
        ./atop.nix
        ./darling.nix
        ./mtr.nix
      ];
      development.imports = [
        ./ccache.nix
        # ./cursor.nix
      ];
      graphical.imports = [
        ./autorandr.nix
        ./bluetooth.nix
        ./flatpak.nix
        ./fonts.nix
        ./plasma.nix
        ./printing.nix
        ./sound.nix
        ./steam.nix
        ./touchpad.nix
        ./xserver.nix
      ];
      networking.imports = [
        ./tailscale.nix
      ];
      wayland.imports = [
        ./wayland.nix
      ];
      testing.imports = [
        # ./edgedb.nix
      ];
    };
  };
}
