{
  flake = {
    nixosModules = {
      default.imports = [
        ./boot
        ./nix
        ./user
      ];
      base.imports = [
        ./environment
        ./fhs-compat
        ./locale
        ./networking
        ./nix-ld
        ./security
        ./services
        ./smart
        ./system
        ./virtualisation
      ];
      commandline.imports = [
        ./atop
        ./darling
        ./mtr
      ];
      development.imports = [
        ./ccache
        # ./cursor
      ];
      gaming.imports = [./hoyo ./steam];
      graphical.imports = [
        ./autorandr
        ./bluetooth
        ./flatpak
        ./fonts
        ./plasma
        ./printing
        ./sound
        ./touchpad
        ./xserver
      ];
      intel-hd.imports = [./intel-hd];
      networking.imports = [
        ./tailscale
        ./wireguard
      ];
      nvidia.imports = [./nvidia];
      wayland.imports = [./wayland];
      testing = {
        imports = [
          # ./edgedb
          ./lix
        ];
      };
    };
  };
}
