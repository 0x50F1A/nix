{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
let
  mpv-config = import ./nix/sources.nix;
  shaderDirectory = "${config.xdg.dataHome}/mpv/shaders";
  mkGLSLShaderList =
    shaderStringList:
    builtins.concatStringsSep ":" (map (shader: "${shaderDirectory}/${shader}.glsl") shaderStringList);
in
{
  _file = ./default.nix;

  options.sof.mpv = {
    enable = lib.mkEnableOption "Soaffine MPV Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.mpv.enable {
    programs = {
      mpv = {
        enable = true;
        config = {
          ### Video ###
          vo = "gpu-next";
          gpu-api = "auto";
          # priority = "high";
          gpu-context = "auto";
          # hwdec = "d3d11va-copy";
          profile = "high-quality";
          # d3d11-adapter = "NVIDIA";
          scale-antiring = 0.6;
          dscale-antiring = 0.6;
          cscale-antiring = 0.6;
          display-fps-override = 60;
          video-sync = "display-resample";
          deband = false;
          deband-iterations = 1;
          deband-threshold = 48;
          deband-range = 16;
          deband-grain = 32;
          temporal-dither = true;
          ## HDR -> SDR ##
          #tone-mapping=bt.2446a
          #tone-mapping-mode=luma
          #target-colorspace-hint=yes
          ### Audio and Subtitles ###
          slang = "en,eng,English";
          alang = "ja,jp,jpn,jap,Japanese,en,eng,English";
          sub-blur = 0.5;
          sub-scale = 0.7;
          sub-margin-y = 60;
          sub-color = "#d6ffffff";
          sub-shadow-offset = 5.0;
          sub-font = builtins.elemAt flake.config.affineUser.theme.defaultFonts.sansSerif 0;
          sub-back-color = "#00000000";
          sub-border-color = "#266a678c";
          sub-shadow-color = "#00000000";
          sub-auto = "all";
          volume-max = 150;
          sub-fix-timing = true;
          audio-channels = "auto";
          blend-subtitles = true;
          sub-ass-override = true;
          audio-file-auto = "fuzzy";
          audio-pitch-correction = true;
          audio-normalize-downmix = true;
          sub-file-paths-append = "subtitles";
          demuxer-mkv-subtitle-preroll = true;
          sub-file-paths = "sub;subs;subtitles";
          af-add = "dynaudnorm=g=5:f=250:r=0.9:p=0.5";
          ### General ###
          fs = true;
          snap-window = true;
          # alpha = "blend";
          keep-open = "always";
          geometry = "50%:50%";
          save-position-on-quit = true;
          watch-later-options-remove = "pause";
          ### OSD/OSC ###
          osc = false;
          border = false;
          osd-bar = false;
          osd-bold = true;
          osd-font-size = 37;
          osd-font = builtins.elemAt flake.config.affineUser.theme.defaultFonts.monospace 0;
        };
        extraInput = ''
          MBTN_LEFT cycle pause #@click
          MBTN_LEFT script-binding evafast/speedup #@press
          MBTN_LEFT script-binding evafast/slowdown #@release
          ALT+d cycle deband
          tab script-binding uosc/flash-ui
          p script-binding webtorrent/toggle-info
          ctrl+d script-binding autodeint/autodeint
          ALT+b script-binding autosub/download_subs
          MOUSE_BTN2 script-binding uosc/menu-blurred
          ALT+a script-message-to uosc show-submenu-blurred "File"
          ALT+z script-message-to uosc show-submenu-blurred "Audio"
          ALT+x script-message-to uosc show-submenu-blurred "Subtitles"
          ALT+s script-message-to uosc show-submenu-blurred "Video > Shaders"
          ### UOSC Menu Config ###
          h script-binding memo-history                                                               #! File > History
          / script-binding console/enable                                                             #! File > Console
          # script-binding uosc/playlist                                                              #! File > Playlist
          # script-binding uosc/open-config-directory                                                 #! File > Settings
          ALT+c script-binding uosc/chapters                                                          #! File > Chapters
          b script-binding uosc/open-file                                                             #! File > Open File
          # script-binding uosc/show-in-directory                                                     #! File > Open in File Explorer
          # apply-profile Deband-Medium                                                               #! Video > Filters > Deband (Medium)
          # apply-profile Deband-Strong                                                               #! Video > Filters > Deband (Strong)
          n cycle-values glsl-shaders "${shaderDirectory}/nlmeans_HQ.glsl" "${shaderDirectory}/nlmeans_L_HQ.glsl" ""  #! Video > Shaders > Denoise
          # change-list glsl-shaders toggle ${shaderDirectory}/adasharp.glsl                                  #! Video > Shaders > Sharpen > Sharpen
          # change-list glsl-shaders toggle ${shaderDirectory}/NVSharpen.glsl                                 #! Video > Shaders > Sharpen > SharpenNV
          # change-list glsl-shaders toggle ${shaderDirectory}/CAS.glsl                                       #! Video > Shaders > Sharpen > SharpenCAS
          # change-list glsl-shaders toggle ${shaderDirectory}/adasharpA.glsl                                 #! Video > Shaders > Line Art > Sharpen
          # change-list glsl-shaders toggle ${shaderDirectory}/A4K_Thin.glsl                                  #! Video > Shaders > Line Art > Thin Line
          # change-list glsl-shaders toggle ${shaderDirectory}/A4K_Dark.glsl                                  #! Video > Shaders > Line Art > Dark Line
          # change-list glsl-shaders toggle ${shaderDirectory}/F16.glsl                                       #! Video > Shaders > Neural Scaler > FSRCNNX 16
          # change-list glsl-shaders toggle ${shaderDirectory}/ravu_L_ar_r4.hook                              #! Video > Shaders > Neural Scaler > Ravu Lite ar r4
          # change-list glsl-shaders toggle ${shaderDirectory}/ravu_Z_ar_r3.hook ; no-osd set cscale-antiring 0 ; set dscale-antiring 0 ; set cscale-antiring 0 #! Video > Shaders > Neural Scaler > Ravu Zoom ar r3
          # change-list glsl-shaders toggle ${shaderDirectory}/F16_LA.glsl                                    #! Video > Shaders > Neural Scaler > FSRCNNX Line Art
          # change-list glsl-shaders toggle ${shaderDirectory}/A4K_Upscale_L.glsl                             #! Video > Shaders > Neural Scaler > Anime4K Upscale L
          # change-list glsl-shaders toggle ${shaderDirectory}/ssimsr.glsl                                    #! Video > Shaders > Generic Scaler > SSimSuperRes
          # change-list glsl-shaders toggle ${shaderDirectory}/CfL_P.glsl                                     #! Video > Shaders > Generic Scaler > CfL Prediction
          # change-list glsl-shaders toggle ${shaderDirectory}/ssimds.glsl ; no-osd set linear-downscaling no #! Video > Shaders > Generic Scaler > SSimDownscaler
          # change-list glsl-shaders toggle ${shaderDirectory}/FSR_EASU.glsl                                  #! Video > Shaders > Generic Scaler > AMD FidelityFX Super Resolution EASU
          Ctrl+3 apply-profile Upscale-FSR                                                            #! Video > Shaders > Profiles > Upscale FSR
          Ctrl+2 apply-profile Upscale-Ravu                                                           #! Video > Shaders > Profiles > Upscale Ravu
          Ctrl+1 apply-profile Upscale-FSRCNNX                                                        #! Video > Shaders > Profiles > Upscale FSRCNNX
          Ctrl+4 apply-profile Enhance-LA                                                             #! Video > Shaders > Profiles > Enhance Line Art
          Ctrl+5 apply-profile UpscaleLA-A4K                                                          #! Video > Shaders > Profiles > Upscale Line Art A4K
          Ctrl+6 apply-profile UpscaleLA-FSRCNNX                                                      #! Video > Shaders > Profiles > Upscale Line Art FSRCNNX
          c change-list glsl-shaders clr all                                                          #! Video > Shaders > Clear All
          g cycle interpolation                                                                       #! Video > Interpolation
          # script-binding uosc/video                                                                 #! Video > Select Video Track
          F1 af toggle "lavfi=[loudnorm=I=-14:TP=-3:LRA=4]" ; show-text "''${af}"                     #! Audio > Dialogue
          # af clr ""                                                                                 #! Audio > Clear Filters
          # script-binding afilter/toggle-eqr                                                         #! Audio > Toggle Equalizer
          a cycle audio-normalize-downmix                                                             #! Audio > Toggle Normalize
          # script-binding afilter/toggle-dnm                                                         #! Audio > Toggle Normalizer
          # script-binding afilter/toggle-drc                                                         #! Audio > Toggle Compressor
          # script-binding uosc/audio                                                                 #! Audio > Select Audio Track
          y script-binding uosc/load-subtitles                                                        #! Subtitles > Load
          Y script-binding uosc/subtitles                                                             #! Subtitles > Select
          ALT+j add sub-scale +0.05                                                                   #! Subtitles > Bigger
          ALT+k add sub-scale -0.05                                                                   #! Subtitles > Smaller
          z add sub-delay -0.1                                                                        #! Subtitles > Decrease Sub Delay
          Z add sub-delay  0.1                                                                        #! Subtitles > Increase Sub Delay
        '';
        profiles = {
          ### Profiles ###
          "Deband-Medium" = {
            deband-iterations = 2;
            deband-threshold = 64;
            deband-range = 16;
            deband-grain = 24;
          };
          "Deband-Strong" = {
            deband-iterations = 3;
            deband-threshold = 64;
            deband-range = 16;
            deband-grain = 24;
          };
          "Upscale-FSRCNNX" = {
            glsl-shaders-clr = true;
            glsl-shaders = mkGLSLShaderList [
              "F16"
              "CfL_P"
              "ssimsr"
              "ssimds"
            ];
            linear-downscaling = false;
          };
          "Upscale-Ravu" = {
            glsl-shaders-clr = true;
            glsl-shaders = mkGLSLShaderList [
              "ravu_Z_ar_r3"
              "CfL_P"
              "ssimds"
            ];
            linear-downscaling = false;
          };
          "Upscale-FSR" = {
            glsl-shaders-clr = true;
            glsl-shaders = mkGLSLShaderList [
              "CfL_P"
              "FSR_EASU"
              "ssimds"
            ];
            linear-downscaling = false;
          };
          "Enhance-LA" = {
            glsl-shaders-clr = true;
            glsl-shaders = mkGLSLShaderList [
              "CfL_P"
              "A4K_Dark"
              "A4K_Thin"
              "adasharpA"
            ];
          };
          "UpscaleLA-FSRCNNX" = {
            glsl-shaders-clr = true;
            glsl-shaders = mkGLSLShaderList [
              "F16_LA"
              "CfL_P"
              "ssimsr"
              "ssimds"
            ];
            linear-downscaling = false;
          };
          "UpscaleLA-A4K" = {
            glsl-shaders-clr = true;
            glsl-shaders = mkGLSLShaderList [
              "A4K_Upscale_L"
              "CfL_P"
              "ssimsr"
              "ssimds"
            ];
            linear-downscaling = false;
          };
          ### Conditional Profiles ###
          "4k-Downscaling" = {
            profile-cond = ''(height >= 2160 or width >= 3840);'';
            profile-restore = "copy-equal";
            glsl-shaders-clr = true;
            glsl-shaders = mkGLSLShaderList [
              "CfL_P"
              "ssimds"
            ];
            linear-downscaling = false;
          };
          "Downmix-Audio-5.1" = {
            profile-cond = ''get("audio-params/channel-count") >= 5 and get("audio-params/channel-count") < 7'';
            profile-restore = "copy-equal";
            volume-max = 200;
            af = ''lavfi="lowpass=c=LFE:f=120,volume=1.6,pan=stereo|FL=0.5*FC+0.707*FL+0.707*BL+0.5*LFE|FR=0.5*FC+0.707*FR+0.707*BR+0.5*LFE"'';
          };
          "Downmix-Audio-7.1" = {
            profile-cond = ''get("audio-params/channel-count") >= 7'';
            profile-restore = "copy-equal";
            volume-max = 200;
            af = ''lavfi="lowpass=c=LFE:f=120,volume=1.6,pan=stereo|FL=0.5*FC+0.3*FLC+0.3*FL+0.3*BL+0.3*SL+0.5*LFE|FR=0.5*FC+0.3*FRC+0.3*FR+0.3*BR+0.3*SR+0.5*LFE"'';
          };
          ## General Anime Profile (Applies to any video in a folder called 'Anime') ##
          "Anime" = {
            profile-cond = ''require'mp.utils'.join_path(working_directory, path):match('\\Anime\\')'';
            profile-restore = "copy-equal";
            deband = true;
            deband-iterations = 2;
            deband-threshold = 35;
            deband-range = 20;
            deband-grain = 5;
            sub-scale = 0.75;
          };
          ## Hides unwanted webtorrent entries in memo script ##
          Webtorrent-Entries = {
            profile-cond = ''string.match(string.lower(string.gsub(require "mp.utils".join_path(get("working-directory", ""), get("path", "")), string.gsub(get("filename", ""), "([^%w])", "%%%1").."$", "")), "webtorrent")'';
            profile-restore = "copy-equal";
            script-opts-append = "memo-enabled=no";
          };
        };
        scriptOpts = {
          console = {
            font = builtins.elemAt flake.config.affineUser.theme.defaultFonts.monospace 0;
          };
          evafast = {
            # How far to jump on press
            seek_distance = 5;
            # Playback speed modifier, applied once every speed_interval until cap is reached
            speed_increase = 0.1;
            speed_decrease = 0.1;
            # At what interval to apply speed modifiers
            speed_interval = 5.0e-2;
            # Playback speed cap
            speed_cap = 2;
            # Playback speed cap when subtitles are displayed, 'no' for same as speed_cap
            subs_speed_cap = 1.8;
            # Multiply current speed by modifier before adjustment (exponential speedup)
            # Use much lower values than default e.g. speed_increase=0.05, speed_decrease=0.025
            multiply_modifier = true;
            # Show current speed on the osd (or flash speed if using uosc)
            show_speed = true;
            # Show current speed on the osd when toggled (or flash speed if using uosc)
            show_speed_toggled = true;
            # Show seek actions on the osd (or flash timeline if using uosc)
            show_seek = true;
          };
          memo = {
            # File path gets expanded, leave empty for in-memory history
            # history_path="~~/script-opts/memo-history.log";
            # How many entries to display in menu
            entries = 10;
            # Display navigation to older/newer entries
            pagination = true;
            # Display files only once
            hide_duplicates = true;
            # Check if files still exist
            hide_deleted = true;
            # Display only the latest file from each directory
            hide_same_dir = false;
            # Date format https://www.lua.org/pil/22.1.html
            timestamp_format = "";
            # Display titles instead of filenames when available
            use_titles = true;
            # Truncate titles to n characters, 0 to disable
            truncate_titles = 60;
            # Meant for use in auto profiles
            enabled = true;
            # Keybinds for vanilla menu
            up_binding = "UP WHEEL_UP";
            down_binding = "DOWN WHEEL_DOWN";
            select_binding = "RIGHT ENTER";
            append_binding = "Shift+RIGHT Shift+ENTER";
            close_binding = "LEFT ESC";
            # Path prefixes for the recent directory menu
            # This can be used to restrict the parent directory relative to which the
            # directories are shown.
            # Syntax
            #   Prefixes are separated by | and can use Lua patterns by prefixing
            #   them with "pattern:", otherwise they will be treated as plain text.
            #   Pattern syntax can be found here https://www.lua.org/manual/5.1/manual.html#5.4.1
            # Example
            #   "path_prefixes=My-Movies|pattern:TV Shows/.-/|Anime" will show directories
            #   that are direct subdirectories of directories named "My-Movies" as well as
            #   "Anime", while for TV Shows the shown directories are one level below that.
            #   Opening the file "/data/TV Shows/Comedy/Curb Your Enthusiasm/S4/E06.mkv" will
            #   lead to "Curb Your Enthusiasm" to be shown in the directory menu. Opening
            #   of that entry will then open that file again.
            path_prefixes = "pattern:.*";
          };
          thumbfast = {
            # Socket path (leave empty for auto)
            socket = "";
            # Thumbnail path (leave empty for auto)
            thumbnail = "";
            # Maximum thumbnail generation size in pixels (scaled down to fit)
            # Values are scaled when hidpi is enabled
            max_height = 200;
            max_width = 200;
            # Scale factor for thumbnail display size (requires mpv 0.38+)
            # Note that this is lower quality than increasing max_height and max_width
            scale_factor = 1;
            # Apply tone-mapping, no to disable
            tone_mapping = "auto";
            # Overlay id
            overlay_id = 42;
            # Spawn thumbnailer on file load for faster initial thumbnails
            spawn_first = true;
            # Close thumbnailer process after an inactivity period in seconds, 0 to disable
            quit_after_inactivity = 0;
            # Enable on network playback
            network = true;
            # Enable on audio playback
            audio = false;
            # Enable hardware decoding
            hwdec = true;
            # Windows only: use native Windows API to write to pipe (requires LuaJIT)
            # direct_io=false;
            # Custom path to the mpv executable
            mpv_path = lib.getExe pkgs.mpv;
          };
          uosc = {
            # Display style of current position. available: line, bar
            timeline_style = "line";
            # Line display style config
            timeline_line_width = 2;
            # Timeline size when fully expanded, in pixels, 0 to disable
            timeline_size = 25;
            # Comma separated states when element should always be fully visible.
            # Available: paused, audio, image, video, idle, windowed, fullscreen
            timeline_persistency = "";
            # Top border of background color to help visually separate timeline from video
            timeline_border = 1;
            # When scrolling above timeline, wheel will seek by this amount of seconds
            timeline_step = 5;
            # Render cache indicators for streaming content
            timeline_cache = true;

            # When to display an always visible progress bar (minimized timeline). Can be: windowed, fullscreen, always, never
            # Can also be toggled on demand with `toggle-progress` command.
            progress = "windowed";
            progress_size = 2;
            progress_line_width = 20;

            # A comma delimited list of controls above the timeline. Set to `never` to disable.
            # Parameter spec: enclosed in `{}` means value, enclosed in `[]` means optional
            # Full item syntax: `[<[!]{disposition1}[,[!]{dispositionN}]>]{element}[:{paramN}][#{badge}[>{limit}]][?{tooltip}]`
            # Common properties:
            #   `{icon}` - parameter used to specify an icon name (example: `face`)
            #            - pick here: https://fonts.google.com/icons?icon.platform=web&icon.set=Material+Icons&icon.style=Rounded
            # `{element}`s and their parameters:
            #   `{shorthand}` - preconfigured shorthands:
            #        `play-pause`, `menu`, `subtitles`, `audio`, `video`, `playlist`,
            #        `chapters`, `editions`, `stream-quality`, `open-file`, `items`,
            #        `next`, `prev`, `first`, `last`, `audio-device`, `fullscreen`,
            #        `loop-playlist`, `loop-file`, `shuffle`
            #   `speed[:{scale}]` - display speed slider, [{scale}] - factor of controls_size, default: 1.3
            #   `command:{icon}:{command}` - button that executes a {command} when pressed
            #   `toggle:{icon}:{prop}[@{owner}]` - button that toggles mpv property
            #   `cycle:{default_icon}:{prop}[@{owner}]:{value1}[={icon1}][!]/{valueN}[={iconN}][!]`
            #       - button that cycles mpv property between values, each optionally having different icon and active flag
            #       - presence of `!` at the end will style the button as active
            #       - `{owner}` is the name of a script that manages this property if any
            #   `gap[:{scale}]` - display an empty gap
            #       {scale} - factor of controls_size, default: 0.3
            #   `space` - fills all available space between previous and next item, useful to align items to the right
            #           - multiple spaces divide the available space among themselves, which can be used for centering
            # Item visibility control:
            #   `<[!]{disposition1}[,[!]{dispositionN}]>` - optional prefix to control element's visibility
            #   - `{disposition}` can be one of:
            #     - `idle` - true if mpv is in idle mode (no file loaded)
            #     - `image` - true if current file is a single image
            #     - `audio` - true for audio only files
            #     - `video` - true for files with a video track
            #     - `has_many_video` - true for files with more than one video track
            #     - `has_image` - true for files with a cover or other image track
            #     - `has_audio` - true for files with an audio track
            #     - `has_many_audio` - true for files with more than one audio track
            #     - `has_sub` - true for files with an subtitle track
            #     - `has_many_sub` - true for files with more than one subtitle track
            #     - `has_many_edition` - true for files with more than one edition
            #     - `has_chapter` - true for files with chapter list
            #     - `stream` - true if current file is read from a stream
            #     - `has_playlist` - true if current playlist has 2 or more items in it
            #   - prefix with `!` to negate the required disposition
            #   Examples:
            #     - `<stream>stream-quality` - show stream quality button only for streams
            #     - `<has_audio,!audio>audio` - show audio tracks button for all files that have
            #                                   an audio track, but are not exclusively audio only files
            # Place `#{badge}[>{limit}]` after the element params to give it a badge. Available badges:
            #   `sub`, `audio`, `video` - track type counters
            #   `{mpv_prop}` - any mpv prop that makes sense to you: https://mpv.io/manual/master/#property-list
            #                - if prop value is an array it'll display its size
            #   `>{limit}` will display the badge only if it's numerical value is above this threshold.
            #   Example: `#audio>1`
            # Place `?{tooltip}` after the element config to give it a tooltip.
            # Example implementations:
            #   menu = command:menu:script-binding uosc/menu-blurred?Menu
            #   subtitles = command:subtitles:script-binding uosc/subtitles#sub?Subtitles
            #   fullscreen = cycle:crop_free:fullscreen:no/yes=fullscreen_exit!?Fullscreen
            #   loop-playlist = cycle:repeat:loop-playlist:no/inf!?Loop playlist
            #   toggle:{icon}:{prop} = cycle:{icon}:{prop}:no/yes!
            controls = "menu,gap,subtitles,<has_many_audio>audio,<has_many_video>video,<has_chapter>chapters,<has_many_edition>editions,<stream>stream-quality,gap,space,speed,space,gap,command:history:script-binding memo-history?History,prev,items,next";
            controls_size = 35;
            controls_margin = 8;
            controls_spacing = 2;
            controls_persistency = "";

            # Where to display volume controls: none, left, right
            volume = "none";
            volume_size = 40;
            volume_border = 1;
            volume_step = 1;
            volume_persistency = "";

            # Playback speed widget: mouse drag or wheel to change, click to reset
            speed_step = 5.0e-2;
            speed_step_is_factor = false;
            speed_persistency = "";

            # Controls all menus, such as context menu, subtitle loader/selector, etc
            menu_item_height = 35;
            menu_min_width = 360;
            menu_padding = 4;
            # Determines if `/` or `ctrl+f` is required to activate the search, or if typing
            # any text is sufficient.
            # When enabled, you can no longer toggle a menu off with the same key that opened it, if the key is a unicode character.
            menu_type_to_search = true;

            # Top bar with window controls and media title
            # Can be: never, no-border, always
            top_bar = "no-border";
            top_bar_size = 45;
            top_bar_controls = true;
            # Can be: `no` (hide), `yes` (inherit title from mpv.conf), or a custom template string
            top_bar_title = true;
            # Template string to enable alternative top bar title. If alt title matches main title,
            # it'll be hidden. Tip: use `${media-title}` for main, and `${filename}` for alt title.
            top_bar_alt_title = "\${filename}";
            # Can be:
            #   `below`  => display alt title below the main one
            #   `toggle` => toggle the top bar title text between main and alt by clicking
            #               the top bar, or calling `toggle-title` binding
            top_bar_alt_title_place = "toggle";
            # Flash top bar when any of these file types is loaded. Available: audio,image,video
            top_bar_flash_on = "video,audio";
            top_bar_persistency = "";
            # Window border drawn in no-border mode
            window_border_size = 1;
            # If there's no playlist and file ends, load next file in the directory
            # Requires `keep-open=yes` in `mpv.conf`.
            autoload = false;
            # What types to accept as next item when autoloading or requesting to play next file
            # Can be: video, audio, image, subtitle
            autoload_types = "video,audio,image";
            # Enable uosc's playlist/directory shuffle mode
            # This simply makes the next selected playlist or directory item be random, just
            # like any other player in the world. It also has an easily togglable control button.
            shuffle = false;
            # Scale the interface by this factor
            scale = 1;
            # Scale in fullscreen
            scale_fullscreen = 1;
            # Adjust the text scaling to fit your font
            font_scale = 1.18;
            # Border of text and icons when drawn directly on top of video
            text_border = 1.2;
            # Border radius of buttons, menus, and all other rectangles
            border_radius = 2;
            # A comma delimited list of color overrides in RGB HEX format. Defaults:
            # foreground=ffffff,foreground_text=000000,background=000000,background_text=ffffff,curtain=111111,success=a5e075,error=ff616e
            # color = ""; # Defined by catppuccin
            # A comma delimited list of opacity overrides for various UI element backgrounds and shapes.
            # This does not affect any text, which is always rendered fully opaque. Defaults:
            # timeline=0.9,position=1,chapters=0.8,slider=0.9,slider_gauge=1,controls=0,speed=0.6,menu=1,submenu=0.4,border=1,title=1,tooltip=1,thumbnail=1,curtain=0.8,idle_indicator=0.8,audio_indicator=0.5,buffering_indicator=0.3,playlist_position=0.8
            opacity = "timeline=0.8,speed=0,menu=0.84,title=0,tooltip=0.8,curtain=0.13";
            # A comma delimited list of features to refine at a cost of some performance impact.
            # text_width - Use a more accurate text width measurement that measures each text string individually
            #              instead of just measuring the width of known letters once and adding them up.
            # sorting    - Use filename sorting that handles non-english languages better, especially asian ones.
            #              At the moment, this is only available on windows, and has no effect on other platforms.
            refine = "text_width";
            # Duration of animations in milliseconds
            animation_duration = 100;
            # Execute command for background clicks shorter than this number of milliseconds, 0 to disable
            # Execution always waits for `input-doubleclick-time` to filter out double-clicks
            click_threshold = 0;
            click_command = "cycle pause; script-binding uosc/flash-pause-indicator";
            # Flash duration in milliseconds used by `flash-{element}` commands
            flash_duration = 1000;
            # Distances in pixels below which elements are fully faded in/out
            proximity_in = 40;
            proximity_out = 120;
            # Use only bold font weight throughout the whole UI
            font_bold = true;
            # One of `total`, `playtime-remaining` (scaled by the current speed), `time-remaining` (remaining length of file)
            destination_time = "total";
            # Display sub second fraction in timestamps up to this precision
            time_precision = 0;
            # Display stream's buffered time in timeline if it's lower than this amount of seconds, 0 to disable
            buffered_time_threshold = 60;
            # Hide UI when mpv autohides the cursor. Timing is controlled by `cursor-autohide` in `mpv.conf` (in milliseconds).
            autohide = false;
            # Can be: flash, static, manual (controlled by flash-pause-indicator and decide-pause-indicator commands)
            pause_indicator = "flash";
            # Sizes to list in stream quality menu
            stream_quality_options = "4320,2160,1440,1080,720,480,360,240,144";
            # Types to identify media files
            video_types = "3g2,3gp,asf,avi,f4v,flv,h264,h265,m2ts,m4v,mkv,mov,mp4,mp4v,mpeg,mpg,ogm,ogv,rm,rmvb,ts,vob,webm,wmv,y4m
audio_types=aac,ac3,aiff,ape,au,cue,dsf,dts,flac,m4a,mid,midi,mka,mp3,mp4a,oga,ogg,opus,spx,tak,tta,wav,weba,wma,wv
image_types=apng,avif,bmp,gif,j2k,jp2,jfif,jpeg,jpg,jxl,mj2,png,svg,tga,tif,tiff,webp
subtitle_types=aqt,ass,gsub,idx,jss,lrc,mks,pgs,pjs,psb,rt,sbv,slt,smi,sub,sup,srt,ssa,ssf,ttxt,txt,usf,vt,vtt";
            # Default open-file menu directory
            default_directory = config.home.homeDirectory;
            # List hidden files when reading directories. Due to environment limitations, this currently only hides
            # files starting with a dot. Doesn't hide hidden files on windows (we have no way to tell they're hidden).
            show_hidden_files = false;
            # Move files to trash (recycle bin) when deleting files. Dependencies:
            # - Linux: `sudo apt install trash-cli`
            # - MacOS: `brew install trash`
            use_trash = false;
            # Adjusted osd margins based on the visibility of UI elements
            adjust_osd_margins = true;
            # Adds chapter range indicators to some common chapter types.
            # Additionally to displaying the start of the chapter as a diamond icon on top of the timeline,
            # the portion of the timeline of that chapter range is also colored based on the config below.
            #
            # The syntax is a comma-delimited list of `{type}:{color}` pairs, where:
            # `{type}` => range type. Currently supported ones are:
            #   - `openings`, `endings` => anime openings/endings
            #   - `intros`, `outros` => video intros/outros
            #   - `ads` => segments created by sponsor-block software like https://github.com/po5/mpv_sponsorblock
            # `{color}` => an RGB(A) HEX color code (`rrggbb`, or `rrggbbaa`)
            #
            # To exclude marking any of the range types, simply remove them from the list.
            chapter_ranges = "openings:30abf964,endings:30abf964,ads:c54e4e80";
            # Add alternative lua patterns to identify beginnings of simple chapter ranges (except for `ads`)
            # Syntax: `{type}:{pattern}[,{patternN}][;{type}:{pattern}[,{patternN}]]`
            chapter_range_patterns = "openings:オープニング;endings:エンディング";
            # Localization language priority from highest to lowest.
            # Also controls what languages are fetched by `download-subtitles` menu.
            # Built in languages can be found in `uosc/intl`.
            # `slang` is a keyword to inherit values from `--slang` mpv config.
            # Supports paths to custom json files: `languages=~~/custom.json,slang,en`
            languages = "slang,en";
            # A comma separated list of element IDs to disable. Available IDs:
            #   window_border, top_bar, timeline, controls, volume,
            #   idle_indicator, audio_indicator, buffering_indicator, pause_indicator
            disable_elements = "";
          };
          webtorrent-mpv-hook = {
            # Path to save downloaded files in. Can be set to "memory" to store all files in RAM.
            path = config.xdg.userDirs.videos;
            # Maximum number of connections.
            maxConns = 100;
            # Port to use for webtorrent web-server.
            # If it's already in use a random port will be chosen instead.
            port = 8888;
            # Enable μTP support.
            utp = true;
            # Enable DHT.
            dht = true;
            # Enable local service discovery.
            lsd = true;
            # Download speed limit in bytes/sec.
            #downloadLimit=
            # Upload speed limit in bytes/sec.
            #uploadLimit=
            # Specify the node command to use.
            # Usefull if the command is called nodejs on your system.
            node_path = lib.getExe pkgs.nodejs;
            # The same text style options as in stats.conf is also available.
          };
        };
        scripts =
          builtins.attrValues {
            inherit (pkgs.mpvScripts)
              autodeint
              autoload
              evafast
              memo
              mpris
              mpv-cheatsheet
              quack
              quality-menu
              reload
              sponsorblock
              thumbfast
              uosc
              webtorrent-mpv-hook
              ;
          }
          ++ [
            (pkgs.mpvScripts.buildLua {
              pname = "inputevent";
              name = "inputevent";
              scriptPath = "inputevent.lua";
              src = mpv-config."mpv-config".outPath + "/portable_config/scripts";
            })
          ];
      };
    };

    home.file = {
      ${shaderDirectory}.source = mpv-config."mpv-config".outPath + "/portable_config/shaders";
    };
  };
}
