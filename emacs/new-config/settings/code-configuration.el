;; Add support to language servers - install the language server first
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(c++-mode . ("ccls"))))

;; complete for corfu
(defun my/eglot-capf ()
  (setq-local completion-at-point-functions
              (list (cape-capf-super
                     #'eglot-completion-at-point
                     #'cape-dabbrev
                     #'cape-file))))

(add-hook 'eglot-managed-mode-hook #'my/eglot-capf)

;; make eglot load automatically depending on the mode
(add-hook 'python-mode-hook 'eglot-ensure)
(add-hook 'python-ts-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'c++-ts-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c-ts-mode-hook 'eglot-ensure)

;; always retrieve the function from eglot; never use the cache
(advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)

;; python virtual environment tracker
;; this detects .venv automatically
(use-package pet
  :ensure t
  :config
  (add-hook 'python-base-mode-hook 'pet-mode -10))

(provide 'code-configuration)
