{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.wayland = {
    enable = lib.mkEnableOption "Soaffine Wayland Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.wayland.enable {
    wayland = {
      windowManager = {
        river = {
          enable = true;
          package = null;
          extraConfig = ''
            rivertile -view-padding 6 -outer-padding 6 &
          '';
          extraSessionVariables = {
            MOZ_ENABLE_WAYLAND = "1";
          };
          settings = {
            background-color = "0x000022";
            border-color-focused = "0xffffff";
            border-color-unfocused = "0xaaaaaa";
            border-width = 2;
            declare-mode = [
              "locked"
              "normal"
              "passthrough"
            ];
            default-layout = "rivertile";
            map = {
              normal = {
                "Super F" = "toggle-fullscreen";
                "Super H" = "send-layout-cmd rivertile 'main-ratio -0.05'";
                "Super J" = "focus-view next";
                "Super K" = "focus-view previous";
                "Super L" = "send-layout-cmd rivertile 'main-ratio +0.05'";
                "Super Q" = "close";
                "Super Period" = "focus-output next";
                "Super Comma" = "focus-output previous";
                "Super Return" = "zoom";
                "Super Space" = "toggle-float";
                "Super+Alt H" = "move left 100";
                "Super+Alt J" = "move down 100";
                "Super+Alt K" = "move up 100";
                "Super+Alt L" = "move right 100";
                "Super+Alt+Control H" = "snap left";
                "Super+Alt+Control J" = "snap down";
                "Super+Alt+Control K" = "snap up";
                "Super+Alt+Control L" = "snap right";
                "Super+Alt+Shift H" = "resize horizontal -100";
                "Super+Alt+Shift J" = "resize vertical 100";
                "Super+Alt+Shift K" = "resize vertical -100";
                "Super+Alt+Shift L" = "resize horizontal 100";
                "Super+Shift Return" = "spawn wezterm";
                "Super+Shift B" = "spawn firefox";
                "Super+Shift E" = "exit";
                "Super+Shift H" = "send-layout-cmd rivertile 'main-count +1'";
                "Super+Shift J" = "swap next";
                "Super+Shift L" = "send-layout-cmd rivertile 'main-count -1'";
                "Super+Shift K" = "swap previous";
                "Super+Shift Period" = "send-to-output next";
                "Super+Shift Comma" = "send-to-output previous";
              };
            };
            map-pointer = {
              normal = {
                "Super BTN_LEFT" = "move-view";
                "Super BTN_RIGHT" = "resize-view";
                "Super BTN_MIDDLE" = "toggle-float";
              };
            };
            rule-add = {
              "-app-id" = {
                "'bar'" = "csd";
              };
            };
            set-repeat = "50 300";
            spawn = [ "wezterm" ];
          };
          systemd = {
            enable = true;
          };
        };
      };
    };
  };
}
