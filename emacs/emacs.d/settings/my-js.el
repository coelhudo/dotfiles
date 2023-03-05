;;; package --- javascript configuration

;;; Commentary:
(require 'lsp-mode)
(require 'js2-mode)
(require 'js2-refactor)
(require 'xref-js2)
(require 'add-node-modules-path)
(require 'web-mode)
(require 'rjsx-mode)


;;; Code:

(use-package js2-mode
  :mode "\\.js\\'"
  :interpreter "node"
  :init
  (setq-default js2-basic-offset 2)
  (add-hook 'js2-mode-hook 'js2-imenu-extras-mode)
  (add-hook 'js2-mode-hook 'electric-pair-mode)
  (add-hook 'js2-mode-hook 'electric-indent-local-mode)
  (add-hook 'js2-mode-hook 'js2-refactor-mode)
  (add-hook 'js2-mode-hook 'skewer-mode)
  (add-hook 'js2-mode-hook (lambda () (add-hook 'after-save-hook 'my/prettier t t)))
  :bind ((:map js-mode-map ("M-." . nil))
         (:map js-mode-map ("C-j" . newline))))

(use-package js2-imenu-extras
  :after js2-mode)

(js2r-add-keybindings-with-prefix "C-c C-r")
(eval-after-load 'js2-mode '(add-hook 'js2-mode-hook #'add-node-modules-path))

(defun my/prettier ()
  (interactive)
  (if (executable-find "prettier")
      (progn (shell-command
              (format "%s --write %s"
                      (shell-quote-argument (executable-find "prettier"))
                      (shell-quote-argument (expand-file-name buffer-file-name))))
             (revert-buffer t t t))))

(use-package rjsx-mode
  :mode ("\\.tsx\\'" "\\.jsx\\'"))

(use-package lsp-mode
  :hook ((js2-mode
          rjsx-mode)
         . lsp-deferred)
  :config
  (advice-add 'json-parse-buffer :around  ;; https://github.com/emacs-lsp/lsp-mode/issues/2681
              (lambda (orig &rest rest)
                (while (re-search-forward "\\u0000" nil t)
                  (replace-match ""))
                (apply orig rest))))

(provide 'my-js)

;;; my-js.el ends here
