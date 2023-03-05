(use-package company
  :ensure t
  :after lsp-mode
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 3)
  :config
  (global-company-mode nil)
  (add-to-list 'company-backends '(company-capf :with company-yasnippet))
  (add-to-list 'company-backends 'company-omnisharp)
  :bind ((:map company-active-map
               ("<tab>" . company-complete-selection))
         (:map lsp-mode-map
               ("<tab>" . company-indent-or-complete-common))))

(use-package company-yasnippet)
(use-package company-dabbrev)
(use-package company-dabbrev-code)
(use-package company-bbdb)
(use-package company-semantic)
(use-package company-files)
(use-package company-gtags)
(use-package company-etags)
(use-package company-keywords)
(use-package company-oddmuse)


(provide 'my-company)
