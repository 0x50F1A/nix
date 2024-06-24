{
  flake = {
    homeModules = {
      base = {
        imports = [
          ./misc/base
          ./catppuccin
          ./git
          ./home-manager
          ./nix-index
          ./xdg
          ./zsh
          ../users
        ];
      };
      commandline = {
        imports = [
          ./misc/commandline
          ./atuin
          ./autojump
          ./aws
          ./bat
          ./broot
          ./carapace
          ./cava
          ./comodoro
          ./darcs
          ./dircolors
          ./direnv
          ./eza
          ./fd
          ./fzf
          ./gallery-dl
          ./gh
          ./git-cliff
          ./git-credential-oauth
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
          ./flameshot
          ./gtk
          ./kitty
          ./pointerCursor
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
          ./zed
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
