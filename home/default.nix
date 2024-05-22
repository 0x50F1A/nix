{
  self,
  inputs,
  ...
}: {
  flake = {
    homeModules = {
      base = {
        imports = [
          ./misc/base.nix
          ./git.nix
          ./home-manager.nix
          ./nix-index.nix
          ./xdg.nix
          ./zsh.nix
        ];
      };
      commandline = {
        imports = [
          ./misc/commandline.nix
          ./atuin.nix
          ./autojump.nix
          ./bat.nix
          ./broot.nix
          ./carapace.nix
          ./comodoro.nix
          ./dircolors.nix
          ./direnv.nix
          ./eza.nix
          ./fzf.nix
          ./gallery-dl.nix
          ./gh.nix
          ./git-cliff.nix
          ./gitui.nix
          ./helix.nix
          ./himalaya.nix
          ./htop.nix
          ./hyfetch.nix
          ./info.nix
          ./joshuto.nix
          ./jujutsu.nix
          ./less.nix
          ./lazygit.nix
          ./micro.nix
          ./mcfly.nix
          ./navi.nix
          ./nnn.nix
          ./ripgrep.nix
          ./rbw.nix
          ./skim.nix
          ./starship.nix
          ./tealdeer.nix
          ./tmux.nix
          ./zoxide.nix
        ];
      };
      extra = {
        imports = [
          ./bottom.nix
          ./ion.nix
          ./nushell.nix
          ./packages.nix
        ];
      };
      graphical = {
        imports = [
          ./misc/graphical.nix
          ./alacritty.nix
          ./cursor.nix
          ./flameshot.nix
          ./gtk.nix
          ./kitty.nix
          ./wezterm.nix
        ];
      };
      internet = {
        imports = [
          ./misc/internet.nix
          ./aria2.nix
          ./chromium.nix
          ./discord.nix
          ./firefox.nix
          ./hexchat.nix
          ./nheko.nix
          ./ssh.nix
          ./syncthing.nix
          ./thunderbird.nix
          ./tiny.nix
          ./tmate.nix
          ./yt-dlp.nix
        ];
      };
      media = {
        imports = [
          ./misc/media.nix
          ./mangohud.nix
          ./mpv.nix
          ./mpris-proxy.nix
          ./ncmpcpp.nix
          ./ncspot.nix
          ./spotify.nix
        ];
      };
      productivity = {
        imports = [
          ./misc/productivity.nix
          ./pandoc.nix
          ./papis.nix
          ./sioyek.nix
        ];
      };
      programming = {
        imports = [
          ./misc/programming.nix
          ./deployment.nix
          ./dhall.nix
          ./editorconfig.nix
          ./go.nix
          ./java.nix
          ./jq.nix
          ./k9s.nix
          ./kakoune.nix
          ./mercurial.nix
          ./mise.nix
          ./neovim.nix
          ./ocaml.nix
          ./octant.nix
          ./piston-cli.nix
          ./python.nix
          ./ruby.nix
          ./scala.nix
          ./vscode.nix
        ];
      };
      security-tools = import ./security-tools.nix;
      wayland = {
        imports = [
          ./misc/wayland.nix
          ./wayland.nix
          ./fuzzel.nix
          ./havoc.nix
          ./mako.nix
          ./swaylock.nix
        ];
      };
    };
  };
}
