(require 'package)
(package-initialize)
(require 'use-package)

(server-start)

(setq tramp-default-method "ssh")

;; Aesthetics
(add-to-list 'default-frame-alist
             '(font . "Fira Mono-14"))
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(setq-default show-trailing-whitespace t)

;; Start Emacs full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Tabs are evil
(setq-default indent-tabs-mode nil)

;; Give me brace matching
(electric-pair-mode 1)

(use-package company
  :diminish company-mode
  :init
  (global-company-mode))

(use-package dante
  :after haskell-mode
  :commands 'dante-mode
  :config
  (add-hook 'haskell-mode-hook 'dante-mode)
  (add-hook 'haskell-mode-hook 'flycheck-mode))

(use-package diminish)

(use-package ensime
  :after (evil)
  :bind ( ;; Cmd+{C, V} work with the OS clipboard
         :map evil-insert-state-map ("s-v" . clipboard-yank)
         :map evil-visual-state-map ("s-c" . clipboard-kill-ring-save))
  :config
  (setq ensime-startup-notification nil)
  (evil-ex-define-cmd "estart"    'ensime)
  (evil-ex-define-cmd "ereload"   'ensime-reload)
  (evil-ex-define-cmd "eshutdown" 'ensime-shutdown))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (setq x-select-enable-clipboard nil)
  (setq evil-normal-state-tag "NORMAL")
  (setq evil-insert-state-tag "INSERT")
  (setq evil-visual-state-tag "VISUAL"))

(use-package flycheck
  :init
  (global-flycheck-mode))

; (use-package haskell-mode
;   :config
;   (add-hook 'haskell-mode-hook 'flycheck-mode)
;   (add-hook 'haskell-mode-hook 'interactive-haskell-mode))

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

(use-package nix-buffer
  :commands nix-buffer)
;  :config
;  (add-hook 'find-file-hook 'nix-buffer)
;  (add-hook 'haskell-interactive-mode-hook 'nix-buffer))

(use-package paren
  :init
  (setq-default show-paren-when-point-inside-paren t)
  :config
  (show-paren-mode))

(use-package sbt-mode
  :after (evil)
  :preface
  (defun custom/sbt-mode-hook ()
    ; Recover C-d for evil-scroll-down
    (define-key evil-normal-state-local-map (kbd "C-d") 'evil-scroll-down))
  :bind (:map evil-normal-state-map ("C-d" . evil-scroll-down)
         :map evil-normal-state-map (", f" . next-error)
         :map evil-normal-state-map (", q" . previous-error))
  :config
  (evil-ex-define-cmd "sstart" 'sbt-start)
  (evil-ex-define-cmd "scmd"   'sbt-command)
  (evil-ex-define-cmd "sprev"  'previous-error)
  (add-hook 'sbt-mode-hook 'custom/sbt-mode-hook))

(use-package spaceline-config
  :config
  (setq powerline-default-separator 'bar)
  (spaceline-spacemacs-theme))

(use-package projectile
  :after (evil)
  :diminish projectile-mode
  :bind (:map evil-normal-state-map (", l" . projectile-switch-project)
         :map evil-normal-state-map (", v" . projectile-find-file))
  :config
  (projectile-global-mode 1))

(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t))

(use-package term
  :after (evil)
  :preface
  (defun custom/term-mode-hook ()
    ; Send the following keys directly to terminal
    ; Adapted from https://stackoverflow.com/a/34404700
    (define-key evil-insert-state-local-map (kbd "C-c") 'term-send-raw)
    (define-key evil-insert-state-local-map (kbd "C-d") 'term-send-raw)
    ; Hide line numbers
    (linum-mode 0))
  (defun custom/create-term (name)
    (interactive "sEnter terminal name: ")
    (ansi-term "bash" name))
  :config
  (add-hook 'term-mode-hook 'custom/term-mode-hook)
  (evil-ex-define-cmd "term" 'custom/create-term))

(use-package undo-tree
  :diminish undo-tree-mode)

(use-package yasnippet
  :diminish yas-minor-mode)
