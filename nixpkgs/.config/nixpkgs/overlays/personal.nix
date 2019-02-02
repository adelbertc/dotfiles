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
        nixpkgsUnstable = import (self.fetchFromGitHub {
          owner  = "NixOS";
          repo   = "nixpkgs";
          rev    = "3eed6d45739bfb6ef4e74837199021fe129a1f1f";
          sha256 = "068zwvlhizayrz6hhkqhl0p9w97wqsi4yfphgq17p4xcvf997nw8";
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

    rustTools = { inherit (self) rustup; };

    scalaTools = { inherit (self) ammonite sbt; };

    tex = { inherit (self.texlive.combined) scheme-full; };

    tools = with self; {
      inherit git nix-repl ripgrep shellcheck stow;
    };
  };
}