{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      # backblaze-b2

      bandwhich
      diskonaut
      du-dust
      dua
      duf
      entr
      fwupd
      glances
      iperf3
      iotop
      kmon
      ldns
      lnav
      lsof
      mosh
      minesweep-rs
      ncdu
      smartmontools
      pict-rs
      pipes-rs
      pokeget-rs
      procs
      psmisc
      # systeroid # 2024-03-13 # did not build

      sysz
      thefuck
      ;
    inherit (pkgs.bat-extras)
      batdiff
      batgrep
      batman
      batwatch
      prettybat
      ;
  };
}
