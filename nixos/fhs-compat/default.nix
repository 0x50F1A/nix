{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;
  options.sof.fhs-compat = {
    enable = lib.mkEnableOption "Soaffine File Hierarchy System Compatibility" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.fhs-compat.enable {
    services.envfs.enable = true;
    environment.systemPackages = [ pkgs.fuse ];
    programs.nix-ld = {
      enable = true;
      libraries = builtins.attrValues {
        inherit (pkgs)
          curl
          expat
          fuse
          fuse3
          glib
          icu
          libsecret
          libunwind
          libuuid
          nss
          openssl
          util-linux
          zlib
          ;
        inherit (pkgs.stdenv.cc) cc;
      };
    };
  };
}
