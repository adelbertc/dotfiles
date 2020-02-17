self: super: {
  personal = {
    emacsPackagesNg =
      let
        pkgs = import (fetchGit {
          url = "https://github.com/NixOS/nixpkgs.git";
          rev = "5f2a3bef33523086007ca6eea84183e08c3c2771";
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
        version = "20200217.1958";
        src = fetchGit {
          url = "https://github.com/emacs-lsp/lsp-mode.git";
          rev = "0bfd69651ba2273469a888e4c04aea6257de1478";
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
        version = "20200217.1619";
        src = fetchGit {
          url = "https://github.com/emacs-lsp/lsp-ui.git";
          rev = "e8200e3b72ecb203a854224eaf73a2194cb4ba46";
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
