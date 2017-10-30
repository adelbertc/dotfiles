{
  packageOverrides = pkgs: rec {
    myDevStuff = with pkgs; {
      inherit git nix-repl ripgrep stow;

      # ENSIME needs websocket_client and sexpdata, see http://ensime.org/editors/vim/install/
      neovim = neovim.override { extraPythonPackages = with pythonPackages; [ websocket_client sexpdata ]; };
    };

    myHaskellStuff  = with pkgs; { inherit cabal-install cabal2nix stack; };

    myTexStuff      = with pkgs; { inherit (texlive.combined) scheme-full; };

    myScalaStuff    = with pkgs; { inherit sbt; };
  };
}
