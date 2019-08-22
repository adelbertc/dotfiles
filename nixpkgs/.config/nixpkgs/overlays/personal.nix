self: super: {
  picofeed = self.stdenv.mkDerivation rec {
    name = "picofeed-${version}";
    version = "1.0";

    src = self.fetchurl {
      url = "https://github.com/seenaburns/picofeed/releases/download/${version}/picofeed-osx";
      sha256 = "107dina9qbkr69y7kwpcdh76qy9bh478j0favyr8ykwl6mg3q5s1";
      curlOpts = ["-L"];
    };

    phases = "installPhase";

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/picofeed
      chmod +x $out/bin/picofeed
    '';
  };

  personal = {
    emacs =
      let
        emacs = self.emacsPackagesNg.overrideScope' (eself: esuper: {
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
        });

        scala-metals = self.stdenv.mkDerivation rec {
          name = "scala-metals-${version}";
          version = "0.7.0";
          phases = "buildPhase";
          buildInputs = [ self.coursier ];
          buildPhase = ''
            mkdir -p $out/bin

            tmp_cache=$(mktemp -d)

            COURSIER_CACHE=$tmp_cache coursier bootstrap \
              --java-opt -Xss4m \
              --java-opt -Xms100m \
              --java-opt -Dmetals.client=emacs \
              org.scalameta:metals_2.12:${version} \
              -r bintray:scalacenter/releases \
              -r sonatype:snapshots \
              -o $out/bin/metals-emacs -f
          '';
        };
      in
        {
          inherit (self) coreutils direnv;
          inherit scala-metals;

          emacs = emacs.emacsWithPackages (epkgs: (with epkgs; [
            company
            diminish
            direnv
            evil
            evil-collection
            flycheck
            linum-relative
            markdown-mode
            spaceline
            projectile
            base16-theme
            use-package

            # Haskell
            dante
            haskell-mode

            # LSP
            lsp-mode
            lsp-ui
            company-lsp

            # Nix
            nix-mode

            # Rust
            cargo
            rust-mode

            # Scala
            scala-mode
            sbt-mode
            mustache-mode

            terraform-mode
            company-terraform

            ansible
            company-ansible

            yaml-mode
          ]));
        };

    haskellTools = with self; { inherit cabal-install stack; };

    neovim = self.neovim.override {
      configure = {
        vam.pluginDictionaries = [
          {
            names = [
              "deoplete-nvim"
              "fugitive"
              "fzf-vim"
              "fzfWrapper"
              "goyo"
              "neomake"
              "nerdtree"
              "vim-airline"
              "vim-airline-themes"
              "Solarized"
              "vim-nix"
            ];
          }
        ];

        # a hack to load user's vim config
        customRC = "source ~/.config/nvim/init.vim";
      };
    };

    rustTools = { inherit (self) rustup; };

    scalaTools = { inherit (self) ammonite sbt; };

    tex = { inherit (self.texlive.combined) scheme-full; };

    tools = with self; {
      inherit git nix-repl ripgrep shellcheck stow;
    };
  };
}
