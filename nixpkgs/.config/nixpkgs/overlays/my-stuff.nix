self: super: {
  personal = {
    emacs = self.emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
      company
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
      nix-mode

      # Scala
      ensime
    ]));

    haskellTools = with self; { inherit cabal-install cabal2nix stack; };

    scalaTools = { inherit (self) sbt; };

    tex = { inherit (self.texlive.combined) scheme-full; };

    tools = with self; {
      inherit git nix-repl ripgrep stow;

      # ENSIME needs websocket_client and sexpdata, see http://ensime.org/editors/vim/install/
      neovim = neovim.override { extraPythonPackages = with pythonPackages; [ websocket_client sexpdata ]; };
    };
  };
}
