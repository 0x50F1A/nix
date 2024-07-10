{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.tiny = {
    enable = lib.mkEnableOption "Soaffine Tiny Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.tiny.enable {
    programs = {
      tiny = {
        enable = true;
        settings = {
          servers = [
            {
              addr = "irc.libera.chat";
              port = 6697;
              join = [
                "#crypto"
                "#hardware"
                "#kde"
                "#linux"
                "##math"
                "#networking"
                "#nixos"
                "##programming"
                "##rust"
                "#security"
                "#zig"
              ];
            }
            {
              addr = "irc.oftc.net";
              port = 6697;
              join = [
                "#asahi"
                "#asah-dev"
                "#ceph"
                "#fdroid"
                "#freedesktop"
                "#mm"
                "#linux"
                "#llvm"
                "#pipewire"
                "#Qubes_OS"
                "#s6"
                "#tiny"
                "#wikicensorship"
              ];
            }
            {
              addr = "irc.rizon.net";
              port = 6697;
              join = [
                "#/g/technology"
                "#/g/sicp"
                "#Canada"
                "#chat"
                "#computertech"
                "#news"
              ];
            }
          ];
          defaults = {
            nicks = [
              "soaffine"
              "affinetyped"
              "soaffine_"
            ];
            realname = flake.config.affineUser.name;
            tls = true;
          };
        };
      };
    };
  };
}
