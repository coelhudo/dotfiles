;;; package --- provides my python configuration


(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup)
  (setq jedi:complete-on-dot t))



(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))

(use-package flycheck
  :ensure t
  :init
  (progn
    (global-flycheck-mode t)
    (set-face-attribute 'flycheck-warning nil :foreground nil)
    (set-face-attribute 'flycheck-error nil :background nil)))

(use-package elpy
  :ensure t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :bind (("C-c C-o" . elpy-occur-definitions))
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules)))

(use-package python-pytest
  :after python)

;; (use-package pytest
;;   :init
;;   (setq pytest-cmd-flags "-o \"addopts=-x -s\""))



(provide 'my-python)
;;; my-python.el ends here
