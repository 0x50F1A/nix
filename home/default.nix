{
  flake = {
    homeModules = {
      base = {
        imports = [
          ./misc/base
          ./catppuccin
          ./git
          ./home-manager
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
          ./command-not-found
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
          ./lazygit
          ./lf
          ./lsd
          ./micro
          ./mcfly
          ./mr
          ./navi
          ./nix-index
          ./nnn
          ./noti
          ./paging
          ./pls
          ./ripgrep
          ./rbw
          ./sapling
          ./skim
          ./starship
          ./tealdeer
          ./tmux
          ./topgrade
          ./xplr
          ./yazi
          ./zoxide
        ];
      };
      extra = {
        imports = [
          ./bottom
          ./boxxy
          ./ion
          ./nushell
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
          ./rio
          ./rofi
          ./sagemath
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
          ./gpg
          ./hexchat
          ./librewolf
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
          ./kodi
          ./mangohud
          ./mpv
          ./mpris-proxy
          ./music163
          ./ncmpcpp
          ./ncspot
          ./spotify
          ./spotify-player
        ];
      };
      productivity = {
        imports = [
          ./misc/productivity
          ./pandoc
          ./papis
          ./sioyek
          ./tex
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
          ./gradle
          ./java
          ./jq
          ./julia
          ./k9s
          ./kakoune
          ./mercurial
          ./mise
          ./neovim
          ./ocaml
          ./pet
          ./python
          ./ruby
          ./scala
          ./sql
          ./vscode
          ./zed
        ];
      };
      security-tools = {
        imports = [ ./security-tools ];
      };
      videography = {
        imports = [ ./obs-studio ];
      };
      wayland = {
        imports = [
          ./misc/wayland
          ./wayland
          ./fuzzel
          ./havoc
          ./mako
          ./swaylock
          ./swayr
          ./wpaperd
        ];
      };
    };
  };
}
