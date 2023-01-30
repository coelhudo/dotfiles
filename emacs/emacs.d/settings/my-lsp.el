(use-package lsp-mode
  :ensure t
  :commands lsp
  :custom
  ((lsp-prefer-flymake nil)
   (gc-cons-threshold 100000000)
   (read-process-output-max (* 1024 1024)))
  :hook ((c++-mode c-mode java-mode) . lsp))

(use-package lsp-modeline
  :after lsp-mode)

(use-package lsp-headerline
  :after lsp-mode)

(use-package lsp-diagnostics
  :after lsp-mode)

(require 'lsp-ui)
(use-package lsp-ui
  :after lsp-mode
  :diminish
  :commands lsp-ui-mode
  :custom
  ((lsp-ui-doc-delay 1)
   (lsp-ui-doc-include-signature t)
   (lsp-ui-doc-position 'top)))

(use-package dap-mouse
  :after lsp-ui)

(provide 'my-lsp)
