;;; package --- Web related modes
;;; Commentary:
;;; this package deals with html and css stuff

;;; Code:
;; (use-package web-mode
;;   :mode ("\\.html\\'" "\\.css\\'"))
(use-package pug-mode)

(use-package web-mode
  :mode ("\\.html\\'" "\\.cshtml\\'" "\\.razor\\'" "\\.vue\\'"))

(use-package css-mode
  :mode "\\.css\\'")

(use-package js-jsx-mode
  :mode "\\.jsx\\'")

(use-package skewer-css-mode
  :hook (css-mode))

(use-package skewer-html-mode
  :hook (mhtml-mode
         html-mode))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package
 '(lsp-volar :type git :host github :repo "jadestrong/lsp-volar"))

(use-package lsp-volar
  :straight t)

(use-package lsp-mode
  :hook ((html-mode
         css-mode
         web-mode
         js-jsx-mode)
         . lsp-deferred))

(provide 'my-web)
;;; my-web.el ends here
