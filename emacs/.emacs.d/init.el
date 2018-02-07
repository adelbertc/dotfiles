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

;; Tabs are evil
(setq-default indent-tabs-mode nil)

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
  :commands (ido-enable-flex-matching ido-everywhere)
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
  (projectile-global-mode))

(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t))
