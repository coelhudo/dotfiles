;;; package --- provides my python configuration


;; (use-package company-jedi
;;   :ensure t
;;   :init
;;   (add-hook 'python-mode-hook 'jedi:setup)
;;   ;; (add-hook 'python-mode-hook 'jedi:ac-setup)
;;   (setq jedi:complete-on-dot t))
(setq python-indent-guess-indent-offset nil)

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
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  (add-hook 'elpy-mode-hook 'flycheck-mode)
  :config
  ;; (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (setq elpy-company-post-completion-function 'ignore)
  (setq elpy-rpc-virtualenv-path 'current))

(use-package python-pytest
  :after python)

(use-package pytest
  :init
  (setq pytest-cmd-flags "-o \"addopts=-x -s\""))

(use-package ein
  :init
  (setq linum-mode nil)
  (setq ein:output-area-inlined-images t)
  (setq ein:worksheet-enable-undo t)
  (setq company-mode nil)
  (setq global-company-mode nil)
  :bind (("C-x 5 k" . ein:worksheet-kill-cell-km)))

(provide 'my-python)
;;; my-python.el ends here
