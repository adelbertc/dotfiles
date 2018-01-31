(require 'package)
(package-initialize 'noactivate)
(eval-when-compile (require 'use-package))

(menu-bar-mode -1)
(tool-bar-mode -1)

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
