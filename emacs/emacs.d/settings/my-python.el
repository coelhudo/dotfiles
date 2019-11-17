;;; package --- provides my python configuration

(defun my-python-mode-hooks ()
  (jedi:setup)
  (electric-pair-mode))
(add-hook 'python-mode-hook 'my-python-mode-hooks)
(setq jedi:complete-on-dot t)                 ;;; optional

(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))

(use-package flycheck
	     :ensure t
	     :init
	     (progn
	       (global-flycheck-mode t)
	       (set-face-attribute 'flycheck-warning nil :foreground nil)))

(use-package elpy
  :bind (("C-c C-o" . elpy-occur-definitions)))

(use-package pytest
  :init
  (setq pytest-cmd-flags "-o \"addopts=-x -s\""))



(provide 'my-python)
;;; my-python.el ends here
