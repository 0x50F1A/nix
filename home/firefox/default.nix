{
  config,
  flake,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.firefox = {
    enable = lib.mkEnableOption "Soaffine Firefox Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.firefox.enable {
    programs = {
      firefox = {
        enable = true;
        package = pkgs.firefox-beta;
        profiles = {
          default = {
            id = 0;
            name = flake.config.affineUser.name;
            bookmarks = [
              {
                name = "Nix sites";
                toolbar = true;
                bookmarks = [
                  {
                    name = "search";
                    tags = [
                      "search"
                      "nix"
                    ];
                    url = "https://search.nixos.org/packages?channel=unstable";
                  }
                  {
                    name = "home search";
                    tags = [
                      "search"
                      "nix"
                      "home"
                    ];
                    url = "https://home-manager-options.extranix.com/";
                  }
                  {
                    name = "nixos wiki";
                    tags = [
                      "wiki"
                      "nix"
                    ];
                    url = "https://wiki.nixos.org/";
                  }
                  {
                    name = "home manual";
                    tags = [
                      "nix"
                      "home"
                    ];
                    url = "https://nix-community.github.io/home-manager/options.xhtml";
                  }
                  {
                    name = "gitmoji";
                    tags = [
                      "programming"
                      "search"
                    ];
                    url = "https://gitmoji.dev/";
                  }
                ];
              }
            ];
            containers = { };
            extensions = builtins.attrValues {
              inherit (pkgs.nur.repos.rycee.firefox-addons)
                aria2-integration
                augmented-steam
                bitwarden
                buster-captcha-solver
                bypass-paywalls-clean
                chatgptbox
                clearurls
                consent-o-matic
                dearrow
                don-t-fuck-with-paste
                enhancer-for-youtube
                fastforwardteam
                github-file-icons
                pay-by-privacy
                privacy-pass
                pronoundb
                proton-vpn
                protondb-for-steam
                re-enable-right-click
                refined-github
                reddit-enhancement-suite
                return-youtube-dislikes
                rust-search-extension
                seventv
                simple-translate
                simplelogin
                sourcegraph
                sponsorblock
                steam-database
                streetpass-for-mastodon
                to-deepl
                tree-style-tab
                ublock-origin
                unpaywall
                view-image
                zotero-connector
                ;
            };
            search = {
              force = true;
              engines = {
                "Nix Packages" = {
                  urls = [
                    {
                      template = "https://search.nixos.org/packages";
                      params = [
                        {
                          name = "channel";
                          value = "unstable";
                        }
                        {
                          name = "type";
                          value = "packages";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];

                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = [ "@np" ];
                };

                "NixOS Wiki" = {
                  urls = [ { template = "https://wiki.nixos.org/index.php?search={searchTerms}"; } ];
                  iconUpdateURL = "https://wiki.nixos.org/favicon.png";
                  updateInterval = 24 * 60 * 60 * 1000;
                  definedAliases = [ "@nw" ];
                };

                "Google".metaData.alias = "@g";
              };
            };
            settings = {
              browser = {
                search = {
                  region = "US";
                  isUS = true;
                };
                startup = {
                  homepage = "https://news.ycombinator.com";
                };
              };
              distribution = {
                searchplugins.defaultLocale = "en-US";
              };
              extensions = {
                autoDisableScopes = false;
              };
              general = {
                useragent.locale = "en-US";
              };
              gfx = {
                webrender.all = true;
              };
              media = {
                ffmpeg.vaapi.enabled = true;
                ffvpx.enabled = true;
                av1.enabled = true;
              };
            };
          };
        };
      };
    };
  };
}
