{pkgs, ...}: {
  services.envfs.enable = true;
  environment.systemPackages = [pkgs.fuse];
  programs.nix-ld = {
    enable = true;
    libraries = builtins.attrValues {
      inherit
        (pkgs)
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
      inherit
        (pkgs.stenv.cc)
        cc
        ;
    };
  };
}
