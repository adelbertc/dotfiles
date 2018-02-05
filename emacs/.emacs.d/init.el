(require 'package)
(package-initialize)

(require 'use-package)

;; Fonts
(add-to-list 'default-frame-alist
             '(font . "Fira Mono-14"))

;; IDO
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Misc
(global-linum-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-screen t)

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package flycheck-mode
  :init
  (global-flycheck-mode))

(use-package linum-relative
  :config
  (linum-relative-mode))

(use-package projectile
  :bind (:map evil-normal-state-map
              (", v" . projectile-find-file))
  :config
  (projectile-global-mode))

(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t))

(use-package haskell-mode)
