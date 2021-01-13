(require 'lsp-mode)
(require 'js2-mode)
(require 'js2-refactor)
(require 'xref-js2)

(use-package js2-mode
  :mode "\\.js\\'"
  :interpreter "node")

(use-package jsx-mode
  :mode ("\\.tsx\\'" "\\.jsx\\'"))

(use-package lsp-mode
  :hook ((js2-mode
          jsx-mode
          rjsx-mode)
         . lsp-deferred))

(add-hook 'js2-mode-hook 'js2-imenu-extras-mode)
(add-hook 'js2-mode-hook 'electric-pair-mode)
(add-hook 'js2-mode-hook 'js2-refactor-mode)
(add-hook 'js2-mode-hook (lambda ()
                           (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))
(add-hook 'js2-mode-hook 'skewer-mode)

(js2r-add-keybindings-with-prefix "C-c C-r")
(define-key js-mode-map (kbd "M-.") nil)
(define-key js-mode-map (kbd "M-.") nil)


(provide 'my-js)
