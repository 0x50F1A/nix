{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.security-tools = {
    enable = lib.mkEnableOption "Soaffine Security Tools Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.security-tools.enable {
    warnings = lib.optional (config.sof.security-tools.enable) ''
      Security tools enabled: this installs many programs that can be used for security testing. Be sure to use them responsibly.
    '';
    home.packages =
      with pkgs;
      [
        ## === Reverse Engineering ===
        (binwalk.override { visualizationSupport = pkgs.stdenv.isLinux; })
        frida-tools
        gef
        ghidra
        # hex # This package conflicts with Helix as they both try to use the 'hx' binary
        jadx

        ## === Crypto-Stego ===
        ccrypt

        ## === Forensics ===
        ddrescue
        exiv2
        pdf-parser
        bingrep # Greps through binaries from various OSs and architectures, and colors them.

        ## === Networking ===
        arping
        nmap
        ncrack
        wpscan
        socat
        tcpreplay
        tcpdump
        sslsplit
        rustscan
        ssh-audit

        ## === SQL ===
        sqlmc
        sqlmap

        ## === Information Gathering === (see: https://github.com/fabaff/nix-security-box/blob/main/information-gathering.nix)
        # maigret # Not Building 03/13/24 because of https://github.com/xhtml2pdf/xhtml2pdf/issues/751
        metabigor
        socialscan # : CLI for querying username and email usage on online platforms
        poppler_utils # pdf rendering tools

        ## === Cloud Pentesting ===
        pacu
        prowler
        yatas
      ]
      ++ (lib.optionals pkgs.stdenv.isLinux [
        ## === Reverse Engineering ===
        (binwalk.override { visualizationSupport = true; })
        radare2

        ## === Forensics ===
        chkrootkit

        ## === Networking ===
        aircrack-ng
        wireshark
        mitmproxy
        proxychains
        udptunnel
        macchanger
        spike # Network protocol fuzzer
        thc-ipv6 # IPv6 attack toolkit

        ## === Information Gathering === (see: https://github.com/fabaff/nix-security-box/blob/main/information-gathering.nix)
        cloudbrute # : automated infrastructure discovery
        p0f # : passive OS detection based on SYN packets
        sn0int # : semi-automatic OSINT framework and package manager
        urlhunter # : a recon tool that allows searching on URLs that are exposed via shortener services
        # theharvester # : E-mails, subdomains and names harvester # Cannot build 2024-04-03
        ## === Passwords ===
        ares-rs
        hashcat
        hashcat-utils
        john
        lemmeknow
        thc-hydra
      ])
      ++ (lib.optionals (!pkgs.stdenv.isLinux && !pkgs.stdenv.isAarch64) [
        ## === Reverse Engineering ===
        cutter
      ]);
  };
}
