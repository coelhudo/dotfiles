;;; package --- provides my python configuration

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ;;; optional

(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))

(use-package flycheck
	     :ensure t
	     :init
	     (global-flycheck-mode t))

(require 'pytest)


(provide 'my-python)
