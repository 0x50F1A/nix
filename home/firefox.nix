{ flake, pkgs, ... }:
{
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-beta;
      profiles = {
        default = {
          id = 0;
          name = flake.config.people.myself;
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
                  url = "https://search.nixos.org/packages";
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
              ];
            }
          ];
          containers = { };
          extensions = builtins.attrValues {
            inherit (pkgs.nur.repos.rycee.firefox-addons)
              bitwarden
              buster-captcha-solver
              bypass-paywalls-clean
              consent-o-matic
              enhancer-for-youtube
              fastforwardteam
              reddit-enhancement-suite
              sourcegraph
              sponsorblock
              ublock-origin
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
}
