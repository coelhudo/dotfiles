;;; package --- Web related modes
;;; Commentary:
;;; this package deals with html and css stuff

;;; Code:
;; (use-package web-mode
;;   :mode ("\\.html\\'" "\\.css\\'"))

(use-package web-mode
  :mode ("\\.html\\'"))

(use-package css-mode
  :mode ("\\.css\\'"))

(use-package skewer-css-mode
  :hook (css-mode))

(use-package skewer-html-mode
  :hook (mhtml-mode
         html-mode))

(use-package lsp-mode
  :hook ((html-mode
         css-mode
         web-mode)
         . lsp-deferred))

(provide 'my-web)
;;; my-web.el ends here
