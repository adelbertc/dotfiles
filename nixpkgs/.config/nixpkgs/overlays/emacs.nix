self: super: {
  personal = {
    emacsPackagesCustom = eself: esuper: {
      company-lsp = eself.melpaBuild {
        pname = "company-lsp";
        version = "20190525.207";
        src = fetchGit {
          url = "https://github.com/tigersoldier/company-lsp.git";
          rev = "cd1a41583f2d71baef44604a14ea71f49b280bf0";
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
        version = "20190606.1958";
        src = fetchGit {
          url = "https://github.com/emacs-lsp/lsp-mode.git";
          rev = "34b769cebde2b7ba3f11230636a1fcd808551323";
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
        version = "20190523.1521";
        src = fetchGit {
          url = "https://github.com/emacs-lsp/lsp-ui.git";
          rev = "3ccc3e3386732c3ee22c151e6b5215a0e4c99173";
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
