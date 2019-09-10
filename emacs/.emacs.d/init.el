(require 'package)
(package-initialize)
(require 'use-package)

(server-start)

(setq tramp-default-method "ssh")

;; Aesthetics
(add-to-list 'default-frame-alist
             '(font . "Iosevka Term-16"))

(setq frame-title-format nil)
(set-frame-parameter (selected-frame) 'name nil)
(set-frame-parameter (selected-frame) 'title nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(setq-default show-trailing-whitespace t)

;; Backup file behavior
(setq backup-by-copying t
      backup-directory-alist '(("." . "~/.emacs_saves/"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; For Emacs Macports
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'control)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (setq powerline-image-apple-rgb t))

;; Tabs are evil
(setq-default indent-tabs-mode nil)

;; Give me brace matching
(electric-pair-mode 1)

;; Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(use-package ansible
  :defer t)

(use-package company-ansible
  :defer t)

(use-package company
  :init
  (global-company-mode))

(use-package company-lsp
  :defer t)

(use-package direnv
  :config
  (direnv-mode))

(use-package evil
  :init
  (setq evil-want-C-u-scroll  t
        evil-want-integration t
        evil-want-keybinding  nil
        evil-normal-state-tag  "NORMAL"
        evil-insert-state-tag  "INSERT"
        evil-visual-state-tag  "VISUAL"
        evil-replace-state-tag "REPLACE")
  :config
  (evil-mode 1)
  (setq x-select-enable-clipboard nil)
  ;; Ctrl+{C, V} work with the OS clipboard
  (bind-keys :map evil-insert-state-map ("C-v" . clipboard-yank)
             :map evil-visual-state-map ("C-c" . clipboard-kill-ring-save)))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package flycheck
  :init
  (global-flycheck-mode)
  :config
  ;; Workaround to make direnv update environment before loading Flycheck
  (setq flycheck-executable-find
        (lambda (cmd) (direnv-update-environment default-directory) (executable-find cmd))))

(use-package haskell
  :after (direnv)
  :defer t
  :config
  (setq-default flycheck-disabled-checkers (append flycheck-disabled-checkers '(haskell-ghc haskell-stack-ghc))))

(use-package ido
  :init
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  :config
  (ido-mode 1))

(use-package lsp-mode
  :after (direnv evil)
  :bind (:map evil-normal-state-map (", f" . next-error)
         :map evil-normal-state-map (", q" . previous-error))
  :config
  (setq lsp-prefer-flymake nil)
  (setq lsp-enable-snippet nil)
  (setq lsp-file-watch-ignored '(
    "[/\\\\]\\.direnv$"
    ; SCM tools
    "[/\\\\]\\.git$"
    "[/\\\\]\\.hg$"
    "[/\\\\]\\.bzr$"
    "[/\\\\]_darcs$"
    "[/\\\\]\\.svn$"
    "[/\\\\]_FOSSIL_$"
    ; IDE tools
    "[/\\\\]\\.idea$"
    "[/\\\\]\\.ensime_cache$"
    "[/\\\\]\\.eunit$"
    "[/\\\\]node_modules$"
    "[/\\\\]\\.fslckout$"
    "[/\\\\]\\.tox$"
    "[/\\\\]\\.stack-work$"
    "[/\\\\]\\.bloop$"
    "[/\\\\]\\.metals$"
    "[/\\\\]target$"
    ; Autotools output
    "[/\\\\]\\.deps$"
    "[/\\\\]build-aux$"
    "[/\\\\]autom4te.cache$"
    "[/\\\\]\\.reference$")))

(use-package mustache-mode)

(use-package nix-mode
  :defer t
  :config
  (setq-local indent-line-function 'indent-relative))

(use-package org
  :defer t
  :config
  (setq org-hide-emphasis-markers t)
  (custom-theme-set-faces
   'user
   '(fixed-pitch ((t (:family "Iosevka Term"))))))

(use-package paren
  :init
  (setq-default show-paren-when-point-inside-paren t)
  :config
  (show-paren-mode))

(use-package rust-mode
  :defer t
  :config
  (setq-default flycheck-disabled-checkers (append flycheck-disabled-checkers '(rust-cargo rust rust-clippy))))

(use-package cargo
  :hook ((rust-mode . cargo-minor-mode)))

(use-package sbt-mode
  :after (evil scala-mode)
  :commands sbt-start sbt-command
  :preface
  (defun custom/sbt-mode-hook ()
    ; Recover C-d for evil-scroll-down
    (define-key evil-normal-state-local-map (kbd "C-d") 'evil-scroll-down))
  :bind (:map evil-normal-state-map ("C-d" . evil-scroll-down))
  :config
  (evil-ex-define-cmd "scmd" 'sbt-command)
  (add-hook 'sbt-mode-hook 'custom/sbt-mode-hook)
  (substitute-key-definition
    'minibuffer-complete-word
    'self-insert-command
    minibuffer-local-completion-map))

(use-package scala-mode
  :defer t)

(use-package spaceline-config
  :init
  (setq-default
    mode-line-format '("%e" (:eval (spaceline-ml-main)))

    powerline-default-separator 'wave
    ;; Stolen from Spacemacs powerline-scale - makes wave look not-janky
    powerline-height (truncate (* 1.5 (frame-char-height)))

    spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)

  :config
  (spaceline-install
    'main
    '((evil-state :face highlight-face)
      (version-control :when active)
      (projectile-root :when active)
      (buffer-id)
      (buffer-modified))
    '((remote-host :when active)
      ((flycheck-error flycheck-warning flycheck-info) :when active)
      (major-mode)
      (line-column :face highlight-face))))

(use-package projectile
  :after (evil)
  :bind (:map evil-normal-state-map (", l" . projectile-switch-project)
         :map evil-normal-state-map (", v" . projectile-find-file))
  :config
  (put 'projectile-project-compilation-cmd 'safe-local-variable #'stringp)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package base16-theme
  :config
  (load-theme 'base16-default-dark t)
  ;; Set the cursor color based on the evil state
  (defvar custom/base16-colors base16-default-dark-colors)
  (setq evil-emacs-state-cursor   `(,(plist-get custom/base16-colors :base0D) box)
        evil-insert-state-cursor  `(,(plist-get custom/base16-colors :base0D) bar)
        evil-motion-state-cursor  `(,(plist-get custom/base16-colors :base0E) box)
        evil-normal-state-cursor  `(,(plist-get custom/base16-colors :base0B) box)
        evil-replace-state-cursor `(,(plist-get custom/base16-colors :base08) bar)
        evil-visual-state-cursor  `(,(plist-get custom/base16-colors :base09) box)))

(use-package term
  :after (evil)
  :preface
  (defun custom/term-mode-hook ()
    ; Send the following keys directly to terminal
    ; Adapted from https://stackoverflow.com/a/34404700
    (define-key evil-insert-state-local-map (kbd "C-c") 'term-send-raw)
    (define-key evil-insert-state-local-map (kbd "C-d") 'term-send-raw))
  (defun custom/create-term (name)
    (interactive "sEnter terminal name: ")
    (ansi-term "bash" name))
  :config
  (add-hook 'term-mode-hook 'custom/term-mode-hook)
  (evil-ex-define-cmd "term" 'custom/create-term))

(use-package terraform-mode)

(use-package company-terraform
  :after (terraform-mode)
  :defer t
  :config
  (company-terraform-init))

(use-package yaml-mode)
