# Adapted from https://github.com/twlz0ne/nix-gccemacs-darwin/tree/aaacc6dd84dc3e585b4ad653dd3bbbe2cc7e070c

let
  nixpkgs = fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    rev = "51428e8d38271d14146211867984b8742d304ea4";
  };

  pkgs = import nixpkgs { };

  libPath = with pkgs; lib.concatStringsSep ":" [
    "${lib.getLib libgccjit}/lib/gcc/${stdenv.targetPlatform.config}/${libgccjit.version}"
    "${lib.getLib stdenv.cc.cc}/lib"
    "${lib.getLib stdenv.glibc}/lib"
  ];

  emacsRev = "f8505fd3d43dd95492855eac88922b5b27201e7a";

  cleanEnvPatch =  pkgs.fetchpatch {
    name = "clean-env.patch";
    url = "https://raw.githubusercontent.com/nix-community/emacs-overlay/master/patches/clean-env.patch";
    sha256 = "0lx9062iinxccrqmmfvpb85r2kwfpzvpjq8wy8875hvpm15gp1s5";
  };

  trampDetectPatch = pkgs.fetchpatch {
    name = "tramp-detect-wrapped-gvfsd.patch";
    url = "https://raw.githubusercontent.com/nix-community/emacs-overlay/master/patches/tramp-detect-wrapped-gvfsd.patch";
    sha256 = "19nywajnkxjabxnwyp8rgkialyhdpdpy26mxx6ryfl9ddx890rnc";
  };

  overrideSourceRepo = drv: drv.override { srcRepo = true; };

  overrideInstall = drv: drv.overrideAttrs (old: {
    name = "emacsGccDarwin";
    version = "28.0.50";
    src = fetchGit {
      url = "https://github.com/emacs-mirror/emacs";
      ref = "feature/native-comp";
      rev = emacsRev;
    };

    configureFlags = old.configureFlags ++ [ "--with-ns" ];

    patches = [ cleanEnvPatch trampDetectPatch ];

    postPatch = old.postPatch or "" + ''
      substituteInPlace lisp/loadup.el \
      --replace '(emacs-repository-get-version)' '"${emacsRev}"' \
      --replace '(emacs-repository-get-branch)' '"master"'
    '';

    postInstall = old.postInstall or "" + ''
      ln -snf $out/lib/emacs/28.0.50/native-lisp $out/native-lisp
      ln -snf $out/lib/emacs/28.0.50/native-lisp $out/Applications/Emacs.app/Contents/native-lisp
      cat <<EOF> $out/bin/run-emacs.sh
      #!/usr/bin/env bash
      set -e
      exec $out/bin/emacs-28.0.50 "\$@"
      EOF
      chmod a+x $out/bin/run-emacs.sh
      ln -snf ./run-emacs.sh $out/bin/emacs
    '';
  });

  overrideNativeComp = drv: drv.override { nativeComp = true; };

  emacsGccDarwin = builtins.foldl' (drv: fn: fn drv)
    pkgs.emacs [ overrideSourceRepo overrideInstall overrideNativeComp ];
in self: super: {
  inherit emacsGccDarwin;

  emacsGccDarwinNixpkgs = pkgs;
}
