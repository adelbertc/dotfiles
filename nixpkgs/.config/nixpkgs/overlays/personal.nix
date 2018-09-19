self: super: {
  personal = {
    emacs =
      let
        nixpkgsUnstable = import (self.fetchFromGitHub {
          owner  = "NixOS";
          repo   = "nixpkgs";
          rev    = "924edffb0c7c32bbfb6f8b155a3338ede5373eb4";
          sha256 = "0853a1dj9wf7iwp5k7fs2vn2ws2dp6rn5fnwyjgq14n3iv84p4jj";
        }) { };

        emacs = nixpkgsUnstable.emacsPackagesNg.overrideScope (esuper: eself: {
        });
      in
        {
          inherit (self) coreutils direnv; # needed for direnv-mode

          emacs = emacs.emacsWithPackages (epkgs: (with epkgs; [
            company
            diminish
            direnv
            evil
            flycheck
            linum-relative
            markdown-mode
            spaceline
            projectile
            solarized-theme
            use-package

            # Haskell
            dante
            haskell-mode

            # Nix
            nix-mode

            # Rust
            cargo
            rust-mode
            racer

            # Scala
            scala-mode
            sbt-mode
            mustache-mode
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

    scalaTools = { inherit (self) sbt; };

    tex = { inherit (self.texlive.combined) scheme-full; };

    tools = with self; {
      inherit git nix-repl ripgrep shellcheck stow;
    };
  };
}
