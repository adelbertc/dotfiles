self: super: {
  personal = {
    emacsPackagesNg =
      let
        pkgs = import (fetchGit {
          url = "https://github.com/NixOS/nixpkgs.git";
          rev = "4e6826a3b2b4e0e95d0af6ef83360962c78125cb";
        }) { };
      in
        pkgs.emacsPackagesNg;

    emacsPackagesCustom = eself: esuper: {
      company-lsp = eself.melpaBuild {
        pname = "company-lsp";
        version = "20190612.1553";
        src = fetchGit {
          url = "https://github.com/tigersoldier/company-lsp.git";
          rev = "f921ffa0cdc542c21dc3dd85f2c93df4288e83bd";
        };
        packageRequires = with eself; [
          company
          dash
          eself.emacs
          lsp-mode
          s
        ];
        recipe = self.writeText "recipe" ''
          (company-lsp :repo "tigersoldier/company-lsp" :fetcher github)
        '';
      };

      lsp-mode = eself.melpaBuild {
        pname = "lsp-mode";
        version = "20191016.1813";
        src = fetchGit {
          url = "https://github.com/emacs-lsp/lsp-mode.git";
          rev = "df4043082a7bb778b6845d3557304c0a8fd68894";
        };
        packageRequires = with eself; [
          dash
          dash-functional
          eself.emacs
          f
          ht
          markdown-mode
          spinner
        ];
        recipe = self.writeText "recipe" ''
          (lsp-mode :repo "emacs-lsp/lsp-mode" :fetcher github)
        '';
      };

      lsp-ui = eself.melpaBuild {
        pname = "lsp-ui";
        version = "20191016.1644";
        src = fetchGit {
          url = "https://github.com/emacs-lsp/lsp-ui.git";
          rev = "060402eacac963fda5f241b31d4900f552207644";
        };
        packageRequires = with eself; [
          dash
          dash-functional
          eself.emacs
          lsp-mode
          markdown-mode
        ];
        recipe = self.writeText "recipe" ''
          (lsp-ui :repo "emacs-lsp/lsp-ui"
                  :fetcher github
                  :files (:defaults "lsp-ui-doc.html"))
        '';
      };

      nix-mode = eself.melpaBuild {
        pname = "nix-mode";
        version = "20190904.1440";
        src = fetchGit {
          url = "https://github.com/NixOS/nix-mode.git";
          rev = "5b5961780f3b1c1b62453d2087f775298980f10d";
        };
        packageRequires = with eself; [
          eself.emacs
        ];
        recipe = self.writeText "recipe" ''
          (nix-mode :repo "NixOS/nix-mode" :fetcher github
                    :files (:defaults
                    (:exclude "nix-company.el" "nix-mode-mmm.el")))
        '';
      };
    };
  };
}
