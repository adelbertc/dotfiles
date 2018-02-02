(require 'package)
(package-initialize 'noactivate)
(eval-when-compile (require 'use-package))

;; Hide menu bars
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Enable line numbers
(global-linum-mode 1)

;; Disable splash screen
(setq inhibit-startup-screen t)

(use-package evil
  :config
  (evil-mode 1))

(use-package projectile
  :commands projectile-mode
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (projectile-global-mode))

(use-package solarized-theme
  :config
  (load-theme 'solarized-dark t))
