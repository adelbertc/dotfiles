self: super: {
  personal = {
    emacs =
      let
        emacs = self.emacsPackagesNg.overrideScope' super.personal.emacsPackagesCustom;

        scala-metals = self.stdenv.mkDerivation rec {
          name = "scala-metals-${version}";
          version = "0.7.5";
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
            # Style
            base16-theme
            diminish
            spaceline

            # Ergonomics
            company
            evil
            evil-collection

            # Tooling
            direnv
            flycheck
            projectile
            use-package

            # Haskell
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

            # Util
            ansible
            company-ansible

            groovy-mode

            markdown-mode
            mustache-mode

            terraform-mode
            company-terraform

            yaml-mode
          ]));
        };

    haskellTools = with self; { inherit cabal-install stack; };

    rustTools = { inherit (self) rustup; };

    scalaTools = { inherit (self) ammonite sbt; };

    tex = { inherit (self.texlive.combined) scheme-full; };

    tools = with self; {
      inherit git nix-repl ripgrep shellcheck stow;
    };
  };
}
