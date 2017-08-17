{
  packageOverrides = pkgs: rec {
    myDevStuff     = with pkgs; { inherit git neovim nix-repl /* ripgrep */ stow; };

    myHaskellStuff = with pkgs; { inherit cabal-install cabal2nix /* stack */ ; };

    myScalaStuff   = with pkgs; { inherit sbt; };
  };
}
