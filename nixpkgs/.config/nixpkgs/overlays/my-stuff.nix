self: super: rec {
  myDevStuff = with self; {
    inherit git nix-repl ripgrep stow;

    # ENSIME needs websocket_client and sexpdata, see http://ensime.org/editors/vim/install/
    neovim = neovim.override { extraPythonPackages = with pythonPackages; [ websocket_client sexpdata ]; };
  };

  myHaskellStuff  = with self; { inherit cabal-install cabal2nix stack; };

  myTexStuff      = with self; { inherit (texlive.combined) scheme-full; };

  myScalaStuff    = with self; { inherit sbt; };

  myEmacsConfig = ./default.el;

  myEmacs =
    let emacsConfig = ./default.el;
    in
      self.emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
        (self.runCommand "default.el" { } ''
          mkdir -p $out/share/emacs/site-lisp
          cp ${myEmacsConfig} $out/share/emacs/site-lisp/default.el
        '')
        evil
        projectile
        solarized-theme
        use-package
      ]));
}
