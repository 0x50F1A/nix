{
  flake = {
    homeModules = {
      base = {
        imports = [
          ./misc/base
          ./git
          ./home-manager
          ./nix-index
          ./xdg
          ./zsh
        ];
      };
      commandline = {
        imports = [
          ./misc/commandline
          ./atuin
          ./autojump
          ./bat
          ./broot
          ./carapace
          ./cava
          ./comodoro
          ./dircolors
          ./direnv
          ./eza
          ./fzf
          ./gallery-dl
          ./gh
          ./git-cliff
          ./gitui
          ./helix
          ./himalaya
          ./htop
          ./hyfetch
          ./info
          ./joshuto
          ./jujutsu
          ./less
          ./lazygit
          ./micro
          ./mcfly
          ./navi
          ./nnn
          ./ripgrep
          ./rbw
          ./skim
          ./starship
          ./tealdeer
          ./tmux
          ./zoxide
        ];
      };
      extra = {
        imports = [
          ./bottom
          ./boxxy
          ./ion
          ./nushell
          ./packages
        ];
      };
      graphical = {
        imports = [
          ./misc/graphical
          ./alacritty
          ./cursor
          ./flameshot
          ./gtk
          ./kitty
          ./wezterm
        ];
      };
      internet = {
        imports = [
          ./misc/internet
          ./aria2
          ./chromium
          ./discord
          ./firefox
          ./hexchat
          ./nheko
          ./ssh
          ./syncthing
          ./texts
          ./thunderbird
          ./tiny
          ./tmate
          ./yt-dlp
        ];
      };
      media = {
        imports = [
          ./misc/media
          ./apple-music
          ./mangohud
          ./mpv
          ./mpris-proxy
          ./music163
          ./ncmpcpp
          ./ncspot
          ./spotify
        ];
      };
      productivity = {
        imports = [
          ./misc/productivity
          ./pandoc
          ./papis
          ./sioyek
        ];
      };
      programming = {
        imports = [
          ./misc/programming
          ./bun
          ./deployment
          ./dhall
          ./editorconfig
          ./go
          ./java
          ./jq
          ./julia
          ./k9s
          ./kakoune
          ./mercurial
          ./mise
          ./neovim
          ./ocaml
          ./octant
          ./piston-cli
          ./python
          ./ruby
          ./scala
          ./vscode
        ];
      };
      security-tools = import ./security-tools;
      wayland = {
        imports = [
          ./misc/wayland
          ./wayland
          ./fuzzel
          ./havoc
          ./mako
          ./swaylock
        ];
      };
    };
  };
}
