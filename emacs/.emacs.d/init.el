(require 'package)
(package-initialize)
(require 'use-package)

;; Aesthetics
(add-to-list 'default-frame-alist
             '(font . "Fira Mono-14"))
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

;; Start Emacs full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Tabs are evil
(setq-default indent-tabs-mode nil)

;; Give me brace matching
(electric-pair-mode 1)

(use-package ensime
  :config
  (setq ensime-startup-notification nil))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package flycheck
  :init
  (global-flycheck-mode))

(use-package haskell-mode)

(use-package ido
  :init
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  :config
  (ido-mode 1))

(use-package linum
  :config
  (global-linum-mode 1))

(use-package linum-relative
  :config
  (linum-relative-mode))

(use-package nix-mode)

(use-package paren
  :init
  (setq-default show-paren-when-point-inside-paren t)
  :config
  (show-paren-mode))

(use-package projectile
  :bind (:map evil-normal-state-map
              (", v" . projectile-find-file))
  :config
  (projectile-global-mode 1))

(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t))
