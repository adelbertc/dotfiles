(require 'package)
(package-initialize)
(require 'use-package)

(server-start)

(setq tramp-default-method "ssh")

;; Aesthetics
(add-to-list 'default-frame-alist
             '(font . "Fira Mono-14"))

(setq frame-title-format nil)
(set-frame-parameter (selected-frame) 'name nil)
(set-frame-parameter (selected-frame) 'title nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(setq-default show-trailing-whitespace t)

;; For Emacs Macports
(when (eq system-type 'darwin)
  ; (setq mac-command-modifier 'control)
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (setq powerline-image-apple-rgb t))

;; Tabs are evil
(setq-default indent-tabs-mode nil)

;; Give me brace matching
(electric-pair-mode 1)

(use-package company
  :init
  (global-company-mode))

(use-package direnv
  :config
  (direnv-mode))

(use-package evil
  :init
  (setq evil-want-C-u-scroll t
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

(use-package flycheck
  :init
  (global-flycheck-mode)
  :config
  ;; Workaround to make direnv update environment before loading Flycheck
  (setq flycheck-executable-find
        (lambda (cmd) (direnv-update-environment default-directory) (executable-find cmd))))

(use-package flycheck-haskell
  :hook (haskell-mode . flycheck-haskell-setup))

(use-package haskell)

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

(use-package nix-mode
  :config
  (setq-local indent-line-function 'indent-relative))

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
  (evil-ex-define-cmd "scmd" 'sbt-command)
  (add-hook 'sbt-mode-hook 'custom/sbt-mode-hook))

(use-package spaceline-config
  :init
  ; Delicate.. hex values are picked out of the Solarized palette manually
  ; Copied from Spaceline
  (dolist (s '((custom/spaceline-evil-normal  "#586e75"        "Evil normal state face.")
               (custom/spaceline-evil-insert  "DarkGoldenrod2" "Evil insert state face.")
               (custom/spaceline-evil-emacs   "SkyBlue2"       "Evil emacs state face.")
               (custom/spaceline-evil-replace "red"            "Evil replace state face.")
               (custom/spaceline-evil-visual  "maroon"         "Evil visual state face.")
               (custom/spaceline-evil-motion  "plum3"          "Evil motion state face.")))
    (eval `(defface ,(nth 0 s) `((t (:background ,(nth 1 s) :foreground "#073642" :inherit 'mode-line)))
                    ,(nth 2 s) :group 'spaceline)))
  (setq-default
    spaceline-evil-state-faces
    '((normal  . custom/spaceline-evil-normal)
      (insert  . custom/spaceline-evil-insert)
      (emacs   . custom/spaceline-evil-emacs)
      (replace . custom/spaceline-evil-replace)
      (visual  . custom/spaceline-evil-visual)
      (motion  . custom/spaceline-evil-motion))

    mode-line-format '("%e" (:eval (spaceline-ml-main)))
    powerline-default-separator 'wave
    ;; Stolen from Spacemacs powerline-scale
    powerline-height (truncate (* 1.3 (frame-char-height)))
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
  (projectile-global-mode 1))

(use-package solarized-theme
  :init
  ; Kind of a workaround for weird underlining behavior in mode line
  (setq-default solarized-high-contrast-mode-line t)
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
