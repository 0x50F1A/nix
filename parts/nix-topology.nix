{ inputs, system, ... }:
{
  _module.args.pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [ inputs.nix-topology.overlays.default ];
  };
  topology.modules = [
    {
      icons = {
        devices = {
          proton.file = ../media/src/topology/proton-vpn-light.png;
        };
        interfaces = {
          tailscale.file = ../media/src/topology/tailscale-dark.png;
        };
      };
    }
    (
      { config, ... }:
      let
        inherit (config.lib.topology) mkInternet mkRouter mkConnection;
      in
      {
        nodes = {
          internet = mkInternet {
            connections = [
              (mkConnection "router" "wan1")
              (mkConnection "proton" "remote")
            ];
          };

          router = mkRouter "Chalkboard" {
            info = "Chalkboard Router";
            interfaceGroups = [
              [
                "eth1"
                "eth2"
              ]
              [ "wan1" ]
            ];
            connections = {
              eth1 = mkConnection "desktop" "eno1";
              eth2 = mkConnection "htpc" "eth1";
              wifi = mkConnection "laptop" "wnp0s1";
            };
            interfaces = {
              eth1 = {
                addresses = [ "10.0.0.1" ];
                network = "home";
              };
              wifi = {
                network = "home";
              };
            };
          };

          htpc = {
            deviceType = "desktop";
            interfaces.eth1 = { };
          };
        };

        networks = {
          home = {
            name = "Home";
            cidrv4 = "10.0.0.0/24";
          };
        };
      }
    )
  ];
}
