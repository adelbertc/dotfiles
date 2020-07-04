self: super: {
  personal = {
    emacsPackagesNg =
      let
        pkgs = import (fetchGit {
          url = "https://github.com/NixOS/nixpkgs.git";
          rev = "ff1b66eaea4399d297abda7419a330239842d715";
          ref = "nixpkgs-20.03-darwin";
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
        version = "20200703.2118";
        src = fetchGit {
          url = "https://github.com/emacs-lsp/lsp-mode.git";
          rev = "7ce0d789a313b84ef7c1b00b63a3db4cc0959fbe";
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
        version = "20200703.448";
        src = fetchGit {
          url = "https://github.com/emacs-lsp/lsp-ui.git";
          rev = "7d5326430eb88a58e111cb22ffa42c7d131e5052";
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
        version = "20200521.1745";
        src = fetchGit {
          url = "https://github.com/NixOS/nix-mode.git";
          rev = "dc298e77b68296fa76b1b80c825de2a6a3ddc969";
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

      lsp-python-ms = eself.melpaBuild {
        pname = "lsp-python-ms";
        version = "20200701.118";
        src = fetchGit {
          url = "https://github.com/emacs-lsp/lsp-python-ms.git";
          rev = "268bcc7cc9f21529187aebf1bca0fc740a1486c3";
        };
        packageRequires = with eself; [
          cl-lib
          eself.emacs
          lsp-mode
        ];
        recipe = self.writeText "recipe" ''
          (lsp-python-ms :fetcher github :repo "emacs-lsp/lsp-python-ms")
        '';
      };

      poetry = eself.melpaBuild {
        pname = "poetry";
        version = "20200527.948";
        src = fetchGit {
          url = "https://github.com/galaunay/poetry.el.git";
          rev = "d876522e5af576d53c62b2838f85c9441fe62258";
        };
        packageRequires = with eself; [
          eself.emacs
          pyvenv
          transient
        ];
        recipe = self.writeText "recipe" ''
          (poetry
           :fetcher github
           :repo "galaunay/poetry.el")
        '';
      };

      rust-mode = eself.melpaBuild {
        pname = "rust-mode";
        version = "20200618.1314";
        src = fetchGit {
          url = "https://github.com/rust-lang/rust-mode.git";
          rev = "00177f542976601d7f114fed82caaa3daad7b177";
        };
        packageRequires = with eself; [
          eself.emacs
        ];
        recipe = self.writeText "recipe" ''
          (rust-mode :repo "rust-lang/rust-mode"
                     :fetcher github)
        '';
      };

      hydra = eself.melpaBuild {
        pname = "hydra";
        version = "20200608.1528";
        src = fetchGit {
          url = "https://github.com/abo-abo/hydra.git";
          rev = "8a9124f80b6919ad5288172b3e9f46c5332763ca";
        };
        packageRequires = with eself; [
          cl-lib
          lv
        ];
        recipe = self.writeText "recipe" ''
         (hydra :repo "abo-abo/hydra"
                :fetcher github
                :files (:defaults (:exclude "lv.el")))
        '';
      };
    };
  };
}
