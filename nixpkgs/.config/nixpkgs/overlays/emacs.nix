self: super: {
  personal = {
    emacsPackagesNg =
      let
        pkgs = import (fetchGit {
          url = "https://github.com/NixOS/nixpkgs.git";
          rev = "5db81b646a0d7e5f65e76793368415aac91aacaa";
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
        version = "20190828.1641";
        src = fetchGit {
          url = "https://github.com/emacs-lsp/lsp-mode.git";
          rev = "5744a5f6ce7ff491d9fcf228a2a64eb69b802bfb";
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
        version = "20190823.541";
        src = fetchGit {
          url = "https://github.com/emacs-lsp/lsp-ui.git";
          rev = "845fbd40f20d63b9eff592ddefeefd2263f6b27c";
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
        version = "20190703.526";
        src = fetchGit {
          url = "https://github.com/NixOS/nix-mode.git";
          rev = "ddf091708b9069f1fe0979a7be4e719445eed918";
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
