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

(use-package elpy
  :ensure t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  (add-hook 'elpy-mode-hook 'flycheck-mode)
  :config
  ;; (setq elpy-company-post-completion-function 'ignore)
  (setq elpy-rpc-virtualenv-path 'current))

(use-package python-pytest
  :after python)

(use-package pytest
  :init
  (setq pytest-cmd-flags "-o \"addopts=-x -s\""))

(use-package ein
  :ensure t
  ;; :after company
  :init
  (setq linum-mode nil)
  (setq ein:output-area-inlined-images t)
  (setq ein:worksheet-enable-undo t)
  ;; (progn
    ;; (company-mode nil)
    ;; (global-company-mode nil))
  :bind (("C-x 5 k" . ein:worksheet-kill-cell-km)))

(use-package ein:notebook
  ;; :after company
  :init
  (setq linum-mode nil)
  (setq ein:output-area-inlined-images t)
  (setq ein:worksheet-enable-undo t)
  ;; (progn
    ;; (company-mode nil)
    ;; (global-company-mode nil))
  :bind (("C-x 5 k" . ein:worksheet-kill-cell-km)))

(provide 'my-python)
;;; my-python.el ends here
