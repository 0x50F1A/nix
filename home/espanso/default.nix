{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.espanso = {
    enable = lib.mkEnableOption "Soaffine Espanso Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.espanso.enable {
    services = {
      espanso = {
        enable = true;
        package = pkgs.espanso-wayland;
        configs = {
          default = { };
          # Application-specific configurations are not yet supported on wayland as of 2024-07-17
        };
        matches = {
          base = {
            matches = [
              {
                trigger = ":now";
                replace = "It's {{currentdate}} {{currenttime}}";
              }
              {
                trigger = "!..!";
                replace = "…";
              }
            ];
          };
          abbreviation = {
            matches = [
              {
                trigger = ":np";
                replace = "No problem!";
              }
              {
                trigger = ":ty";
                replace = "Thank you!";
              }
              {
                trigger = ":yw";
                replace = "You're welcome!";
              }
            ];
          };
          answerWebsites = {
            matches = [
              {
                trigger = ":answerwell";
                replace = "https://jvns.ca/blog/answer-questions-well/";
              }
              {
                trigger = ":dontask";
                replace = "https://dontasktoask.com/";
              }
              {
                trigger = ":fiveminutes";
                replace = "https://signalvnoise.com/posts/3124-give-it-five-minutes";
              }
              {
                trigger = ":howtoshare";
                replace = "https://github.com/shlomif/how-to-share-code-online";
              }
              {
                trigger = ":itdidnt";
                replace = "https://itdidnt.work/";
              }
              {
                trigger = ":easytodelete";
                replace = "https://programmingisterrible.com/post/139222674273/write-code-that-is-easy-to-delete-not-easy-to";
              }
              {
                trigger = ":example";
                replace = "https://stackoverflow.com/help/minimal-reproducible-example";
              }
              {
                trigger = ":nohi";
                replace = "https://nohello.net/";
              }
              {
                trigger = ":nohello";
                replace = "https://nohello.net/";
              }
              {
                trigger = ":organize";
                replace = "https://goblin.tools";
              }
              {
                trigger = ":quickanswers";
                replace = "https://quick-answers.kronis.dev/";
              }
              {
                trigger = ":rubberduck";
                replace = "https://rubberduckdebugging.com/";
              }
              {
                trigger = ":screenshot";
                replace = "https://www.take-a-screenshot.org/";
              }
              {
                trigger = ":shortexample";
                replace = "http://sscce.org/";
              }
              {
                trigger = ":shoulditbe";
                replace = "https://shoulditbeameeting.com/";
              }
              {
                trigger = ":smartquestions";
                replace = "http://catb.org/~esr/faqs/smart-questions.html";
              }
              {
                trigger = ":thewrongabstraction";
                replcae = "https://sandimetz.com/blog/2016/1/20/the-wrong-abstraction";
              }
              {
                trigger = ":tryit";
                replace = "https://tryitands.ee/";
              }
              {
                trigger = ":wholecode";
                replace = "https://archive.shadowcat.co.uk/blog/matt-s-trout/show-us-the-whole-code/";
              }
              {
                trigger = ":xyp";
                replace = "https://xyproblem.info/";
              }
            ];
          };
          character = {
            matches = [
              {
                trigger = ":ada";
                replace = "₳";
              }
              {
                trigger = ":btc";
                replace = "₿";
              }
              {
                trigger = ":eur";
                replace = "€";
              }

              {
                trigger = ":pound";
                replace = "£";
              }
              {
                trigger = ":yuan";
                replace = "¥";
              }
              {
                trigger = ":yen";
                replace = "¥";
              }
            ];
          };
          emojis = {
            matches = [
              {
                trigger = ":eyes";
                replace = "👀";
              }
              {
                trigger = ":ok";
                replace = "👌";
              }
              {
                trigger = ":pls";
                replace = "🙏";
              }
              {
                trigger = ":thinking";
                replace = "🤔";
              }
              {
                trigger = ":thumbsdown";
                replace = "👎";
              }
              {
                trigger = ":thumbsup";
                replace = "👍";
              }
            ];
          };
          llm = {
            matches = [
              {
                trigger = ":summarize";
                replace = ''
                  TL;DR:

                  {{clipboard}}

                  $|$
                '';
                vars = [
                  {
                    name = "clipboard";
                    type = "clipboard";
                  }
                ];
              }
            ];
          };
          logic = {
            matches = [
              {
                trigger = ":and";
                replace = "∧";
              }
              {
                trigger = ":because";
                replace = "∵";
              }
              {
                trigger = ":contra";
                replace = "⊥";
              }
              {
                trigger = ":entails";
                replace = "⊨";
              }
              {
                trigger = ":exists";
                replace = "∃";
              }
              {
                trigger = ":forall";
                replace = "∀";
              }
              {
                trigger = ":iff";
                replace = "⇔";
              }
              {
                trigger = ":nand";
                replace = "⊼";
              }
              {
                trigger = ":nec";
                replace = "☐";
              }
              {
                trigger = ":nentails";
                replace = "⊭";
              }
              {
                trigger = ":nor";
                replace = "⊽";
              }
              {
                trigger = ":not";
                replace = "¬";
              }
              {
                trigger = ":nproves";
                replace = "⊬";
              }
              {
                trigger = ":or";
                replace = "∨";
              }
              {
                trigger = ":papb";
                replace = "⟛";
              }
              {
                trigger = ":poss";
                replace = "◇";
              }
              {
                trigger = ":proves";
                replace = "⊢";
              }
              {
                trigger = ":taut";
                replace = "⊤";
              }
              {
                trigger = ":then";
                replace = "⇒";
              }
              {
                trigger = ":therefore";
                replace = "∴";
              }
              {
                trigger = ":xnor";
                replace = "⊙";
              }
              {
                trigger = ":xor";
                replace = "⊻";
              }
            ];
          };
          macos = {
            matches = [
              {
                trigger = ":maccmd";
                replace = "⌘";
              }
              {
                trigger = ":macctrl";
                replace = "⌃";
              }
              {
                trigger = ":macesc";
                replace = "⎋";
              }
              {
                triggers = [
                  ":macopt"
                  ":macalt"
                ];
                replace = "⌥";
              }
              {
                trigger = ":macreturn";
                replace = "↩";
              }
              {
                trigger = ":macshift";
                replace = "⇧";
              }
            ];
          };
          markdown = {
            matches = [
              {
                trigger = ":md-link";
                replace = "[$|$]({{link}})";
                vars = [
                  {
                    name = "link";
                    type = "clipboard";
                  }
                ];
              }
            ];
          };
          math = {
            matches = [
              {
                trigger = ":affine";
                replace = "𝔸";
              }
              {
                trigger = ":aleph";
                replace = "ℵ";
              }
              {
                trigger = ":alephnull";
                replace = "ℵ₀";
              }
              {
                trigger = ":approx";
                replace = "≈";
              }
              {
                trigger = ":beth";
                replace = "ℶ";
              }
              {
                trigger = ":bethnull";
                replace = "ℶ₀";
              }
              {
                trigger = ":bethone";
                replace = "ℶ₁";
              }
              {
                trigger = ":chi";
                replace = "χ";
              }
              {
                trigger = ":caution";
                replace = "☡";
              }
              {
                trigger = ":compact";
                replace = "𝕂";
              }
              {
                trigger = ":dot";
                replace = "·";
              }
              {
                trigger = ":defeq";
                replace = "≝";
              }
              {
                trigger = ":del";
                replace = "∇";
              }
              {
                trigger = ":delta";
                replace = "Δ";
              }
              {
                trigger = ":directsum";
                replace = "⊕";
              }
              {
                trigger = ":dispersity";
                replace = "Đ";
              }
              {
                trigger = ":epsilon";
                replace = "ε";
              }
              {
                trigger = ":expected";
                replace = "𝔼";
              }
              {
                trigger = ":falsity";
                replace = "𝟘";
              }
              {
                trigger = ":field";
                replace = "𝔽";
              }
              {
                trigger = ":gal";
                replace = "Γ";
              }
              {
                trigger = ":geq";
                replace = "≥";
              }
              {
                trigger = ":group";
                replace = "𝔾";
              }
              {
                trigger = ":hadamard";
                replace = "⊙";
              }
              {
                trigger = ":ident";
                replace = "≡";
              }
              {
                trigger = ":idento";
                replace = "𝟙";
              }
              {
                trigger = ":inf";
                replace = "∞";
              }
              {
                trigger = ":iso";
                replace = "≅";
              }
              {
                trigger = ":lambda";
                replace = "λ";
              }
              {
                trigger = ":lbin";
                replace = "log₂";
              }
              {
                trigger = ":leteq";
                replace = "≔";
              }
              {
                trigger = ":leq";
                replace = "≤";
              }
              {
                trigger = ":monad";
                replace = "𝕄";
              }
              {
                trigger = ":muchless";
                replace = "≪";
              }
              {
                trigger = ":muchmore";
                replace = "≫";
              }
              {
                trigger = ":neq";
                replace = "≠";
              }
              {
                trigger = ":omega";
                replace = "ω";
              }
              {
                trigger = ":partial";
                replace = "∂";
              }
              {
                trigger = ":pi";
                replace = "π";
              }
              {
                trigger = ":pm";
                replace = "±";
              }
              {
                trigger = ":prob";
                replace = "ℙ";
              }
              {
                trigger = ":prod";
                replace = "∏";
              }
              {
                trigger = ":sphere";
                replace = "𝕊";
              }
              {
                trigger = ":sqrt";
                replace = "√";
              }
              {
                trigger = ":sum";
                replace = "∑";
              }
              {
                trigger = ":tau";
                replace = "τ";
              }
              {
                trigger = ":tensor";
                replace = "⊗";
              }
              {
                trigger = ":times";
                replace = "×";
              }
              {
                trigger = ":vspace";
                replace = "𝕍";
              }
            ];
          };
          programming = {
            matches = [
              {
                trigger = ":abind";
                replace = ">>";
              }
              {
                trigger = ":bind";
                replace = ">>=";
              }
              {
                trigger = ":fft";
                replace = "Fast Fourier Transform";
              }
            ];
          };
          setTheory = {
            matches = [
              {
                trigger = ":algebraics";
                replace = "𝔸";
              }
              {
                trigger = ":booleans";
                replace = "𝔹";
              }
              {
                trigger = ":complex";
                replace = "ℂ";
              }
              {
                trigger = ":discourse";
                replace = "𝔻";
              }
              {
                trigger = ":empty";
                replace = "∅";
              }
              {
                trigger = ":in";
                replace = "∈";
              }
              {
                trigger = ":integers";
                replace = "ℤ";
              }
              {
                trigger = ":irrationals";
                replace = "𝕁";
              }
              {
                trigger = ":naturals";
                replace = "ℕ";
              }
              {
                trigger = ":notin";
                replace = "∉";
              }
              {
                trigger = ":quaternions";
                replace = "ℍ";
              }
              {
                trigger = ":rationals";
                replace = "ℚ";
              }
              {
                trigger = ":reals";
                replace = "ℝ";
              }
              {
                trigger = ":wholes";
                replace = "𝕎";
              }
            ];
          };
          technical = {
            matches = [
              {
                trigger = ":bug";
                replace = ''
                  Steps to reproduce:
                  Expected behavior:
                  Actual behavior:
                '';
              }
              {
                trigger = ":hm";
                replace = "home-manager";
              }
              {
                trigger = ":nos";
                replace = "NixOS";
              }
            ];
          };
          utils = {
            matches = [
              {
                trigger = ":ip";
                replace = "{{output}}";
                vars = [
                  {
                    name = "output";
                    type = "shell";
                    command = "curl 'https://api.ipify.org/";
                  }
                ];
              }
              {
                trigger = ":ipv6";
                replace = "{{output}}";
                vars = [
                  {
                    name = "output";
                    type = "shell";
                    command = "curl 'https://api64.ipify.org/";
                  }
                ];
              }
              {
                trigger = ":paste";
                replace = "{{output}}";
                vars = [
                  {
                    name = "output";
                    type = "clipboard";
                  }
                ];
              }
              {
                trigger = ":weather";
                replace = "{{output}}";
                vars = [
                  {
                    name = "output";
                    type = "shell";
                    command = "curl 'wttr.in/?format=1'";
                  }
                ];
              }
            ];
          };
          global_vars = {
            global_vars = [
              {
                name = "currentdate";
                type = "date";
                params = {
                  format = "%d-%m-%Y";
                };
              }
              {
                name = "currenttime";
                type = "date";
                params = {
                  format = "%R";
                };
              }
            ];
          };
        };
      };
    };
  };
}
