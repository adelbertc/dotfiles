self: super: {
  personal = {
    emacs =
      let
        macEmacsWithPackages = self.emacsPackagesNg.overrideScope (esuper: eself: {
          emacs = self.emacs25Macport;
        });
      in
        macEmacsWithPackages.emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
          company
          diminish
          evil
          flycheck
          linum-relative
          spaceline
          projectile
          solarized-theme
          use-package

          # Haskell
          haskell-mode
          dante

          # Nix
          nix-buffer
          nix-mode

          # Scala
          ensime
        ]));

    haskellTools = with self; { inherit cabal-install cabal2nix stack; };

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
