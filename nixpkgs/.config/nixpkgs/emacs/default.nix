self: super:

let
  default-el  = self.runCommand "default.el" { } ''
    mkdir -p $out/share/emacs/site-lisp
    cp ${./default.el} $out/share/emacs/site-lisp/default.el
  '';
in
  self.emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    default-el

    evil
    projectile
    solarized-theme
    use-package
  ]))
