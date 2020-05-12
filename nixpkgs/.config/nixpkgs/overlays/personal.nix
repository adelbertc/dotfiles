self: super: {
  personal = {
    emacs =
      let
        emacs = super.personal.emacsPackagesNg.overrideScope' super.personal.emacsPackagesCustom;

        mspyls = self.stdenv.mkDerivation rec {
          name = "mspyls-${version}";
          version = "0.5.30";

          nupkg = "Python-Language-Server-osx-x64.${version}.nupkg";

          # You can get a list of download links here:
          # https://pvsc.blob.core.windows.net/python-language-server-stable?restype=container&comp=list&prefix=Python-Language-Server-osx-x64
          src = self.fetchurl {
            url = "https://pvsc.blob.core.windows.net/python-language-server-stable/${nupkg}";
            sha256 = "0ishiy1z9dghj4ryh95vy8rw0v7q4birdga2zdb4a8am31wmp94b";
          };

          nativeBuildInputs = [ self.unzip ];

          phases = "unpackPhase installPhase";

          unpackPhase = ''
            unzip $src
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp -r * $out/bin/

            mspyls_path="$out/bin/Microsoft.Python.LanguageServer"
            chmod a+x $mspyls_path

            mkdir -p $out/share/mspyls
            echo "export MSPYLS_PATH=\"$mspyls_path\"" > $out/share/mspyls/mspyls.sh
          '';
        };

        scala-metals = self.stdenv.mkDerivation rec {
          name = "scala-metals-${version}";
          version = "0.7.6";
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
          inherit mspyls scala-metals;

          emacs = (emacs.emacsWithPackages (epkgs: (with epkgs; [
            # Style
            base16-theme
            diminish
            spaceline

            # Ergonomics
            company
            evil
            evil-collection
            evil-magit
            evil-surround

            # Tooling
            direnv
            flycheck
            hydra
            magit
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

            # Python
            poetry
            lsp-python-ms

            # Scala
            scala-mode
            sbt-mode

            # Util
            ansible
            company-ansible

            dockerfile-mode

            groovy-mode

            json-mode

            markdown-mode
            mustache-mode

            terraform-mode
            company-terraform

            yaml-mode
          ]))).overrideAttrs (oldAttrs: {
            name = "personal-emacs";
          });
        };

    haskellTools = with self; { inherit cabal-install stack; };

    rustTools = { inherit (self) rustup; };

    scalaTools = { inherit (self) ammonite sbt; };

    tex = { inherit (self.texlive.combined) scheme-full; };

    tools = with self; {
      inherit bat git nix-repl ripgrep shellcheck stow tldr;
    };
  };
}
