{
  flake = {
    nixosModules = {
      default.imports = [
        ./boot
        ./nix
        ./user
        ./system
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
        ./virtualisation
      ];
      commandline.imports = [
        ./atop
        ./darling
        ./mtr
      ];
      development.imports = [ ./ccache ];
      gaming.imports = [
        ./hoyo
        ./steam
      ];
      graphical.imports = [
        ./autorandr
        ./bluetooth
        ./fonts
        ./gstreamer
        ./plasma
        ./printing
        ./sound
        ./touchpad
        ./xserver
      ];
      intel-hd.imports = [ ./intel-hd ];
      networking.imports = [
        ./tailscale
        ./wireguard
      ];
      nvidia.imports = [ ./nvidia ];
      wayland.imports = [ ./wayland ];
      testing = {
        imports = [
          ./edgedb
          # ./cursor
          ./lix
        ];
      };
    };
  };
}
