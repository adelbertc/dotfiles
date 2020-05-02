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

      lsp-python-ms = eself.melpaBuild {
        pname = "lsp-python-ms";
        version = "20200501.1408";
        src = fetchGit {
          url = "https://github.com/emacs-lsp/lsp-python-ms.git";
          rev = "109bc24129dc2467d9fd0ca578873b40788b5fa5";
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
        version = "20200326.1328";
        src = fetchGit {
          url = "https://github.com/galaunay/poetry.el.git";
          rev = "6dcc9d22cac6642a861770b5518398d8ee4fcc9a";
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
        version = "20200213.2007";
        src = fetchGit {
          url = "https://github.com/rust-lang/rust-mode.git";
          rev = "63ec74c45231051f8bb64226d1a864f5635ac07a";
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
        version = "20191125.955";
        src = fetchGit {
          url = "https://github.com/abo-abo/hydra.git";
          rev = "d3328cab67714fbc164781d7bbe0f9d150f2e9a3";
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
