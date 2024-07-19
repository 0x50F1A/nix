{
  config,
  flake,
  lib,
  ...
}:
{
  _file = ./default.nix;

  options.sof.glance = {
    enable = lib.mkEnableOption "Soaffine Glance Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.glance.enable {
    services = {
      glance = {
        enable = true;
        settings = {
          pages = [
            {
              name = "Home";
              columns = [
                {
                  size = "small";
                  widgets = [
                    {
                      type = "clock";
                      hour-format = flake.config.affineUser.hourFormat;
                    }
                    {
                      type = "bookmarks";
                      groups = [
                        {
                          links = [
                            {
                              title = "Github";
                              url = "https://github.com";
                            }
                          ];
                        }
                        {
                          title = "Entertainment";
                          color = "50 50 50";
                          links = [
                            {
                              title = "Youtube";
                              url = "https://youtube.com";
                            }
                            {
                              title = "Twitch";
                              url = "https://twitch.tv";
                            }
                          ];
                        }
                        {
                          title = "Social";
                          color = "200 50 50";
                          links = [
                            {
                              title = "Reddit";
                              url = "https://reddit.com";
                            }
                            {
                              title = "Twitter";
                              url = "https://twitter.com";
                            }
                          ];
                        }
                      ];
                    }
                    {
                      type = "twitch-channels";
                      channels = [
                        "atrioc"
                        "carolinekwan"
                        "hasanabi"
                        "northernlion"
                        "willneff"
                      ];
                    }
                  ];
                }
                {
                  size = "full";
                  widgets = [
                    {
                      type = "search";
                      search-engine = "google";
                    }
                    { type = "hacker-news"; }
                    {
                      type = "reddit";
                      subreddit = "neoliberal";
                    }
                    {
                      type = "reddit";
                      subreddit = "programming";
                    }
                    {
                      type = "videos";
                      channels = [
                        "UCgv4dPk_qZNAbUW9WkuLPSA" # Atrioc
                        "UC554eY5jNUfDq3yDOJYirOQ" # Destiny
                        "UCXl4i9dYBrFOabk0xGmbkRA" # Dwarkesh
                        "UC_O58Rr2DOskJvs9bArpLkQ" # Librarian
                        "UC3tNpTOHsTnkmbwztCs30sA" # NL
                        "UC8ENHE5xdFSwx71u3fDH5Xw" # Primeagen
                      ];
                    }
                    { type = "lobsters"; }
                  ];
                }
                {
                  size = "small";
                  widgets = [
                    {
                      type = "weather";
                      location = flake.config.affineUser.location;
                    }
                    { type = "calendar"; }
                    {
                      type = "markets";
                      markets = [
                        {
                          symbol = "TQQQ";
                          name = "Total Market";
                        }
                        {
                          symbol = "NVDA";
                          name = "Nvidia";
                        }
                      ];
                    }
                  ];
                }
              ];
            }
            {
              name = "Markets";
              columns = [
                {
                  size = "small";
                  widgets = [
                    {
                      type = "clock";
                      hour-format = "24h";
                    }
                  ];
                }
                {
                  size = "full";
                  widgets = [
                    {
                      type = "markets";
                      markets = [
                        {
                          symbol = "TQQQ";
                          name = "Total Market";
                        }
                        {
                          symbol = "NVDA";
                          name = "Nvidia";
                        }
                        {
                          symbol = "AMD";
                          name = "AMD";
                        }
                        {
                          symbol = "AAPL";
                          name = "Apple";
                        }
                        {
                          symbol = "GOOGL";
                          name = "Google";
                        }
                        {
                          symbol = "AMZN";
                          name = "Amazon";
                        }
                        {
                          symbol = "MSFT";
                          name = "Microsoft";
                        }
                        {
                          symbol = "TSLA";
                          name = "Tesla";
                        }
                        {
                          symbol = "BTC-USD";
                          name = "Bitcoin";
                        }
                        {
                          symbol = "ETH-USD";
                          name = "Ethereum";
                        }
                      ];
                    }
                  ];
                }
              ];
            }
            {
              name = "Calendar";
              columns = [
                {
                  size = "small";
                  widgets = [
                    {
                      type = "clock";
                      hour-format = flake.config.affineUser.hourFormat;
                    }
                    {
                      type = "weather";
                      location = flake.config.affineUser.location;
                    }
                  ];
                }
                {
                  size = "full";
                  widgets = [ { type = "calendar"; } ];
                }
              ];
            }
          ];
        };
      };
    };
  };
}
