(use-package haskell-mode
  :mode ("\\.hs\\'" . haskell-mode))

(use-package arduino-mode
  :mode ("\\.ino\\'" . arduino-mode))

(use-package restclient-mode
  :mode ("\\.rest\\'" . restclient-mode))

(use-package csharp-mode
  :mode "\\.cs\\'"
  :init
  (defun my/csharp-mode-hook ()
    (setq-local lsp-auto-guess-root t)
    (lsp))
  (add-hook 'csharp-mode-hook #'my/csharp-mode-hook))

(use-package php-mode
  :mode "\\.php\\'")

(use-package lsp-mode
  :hook php-mode)

(use-package xml-mode
  :mode ("\\.csproj\\'" "\\.xml\\'"))

(require 'dap-netcore)
(require 'csharp-mode)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package
 '(unity :type git :host github :repo "elizagamedev/unity.el"))
(add-hook 'after-init-hook #'unity-mode)


;; if the project isn't under a VCS, then this is necessary to find the project root
(cl-defmethod project-root ((project (head csharp)))
  (cdr project))

(defun my/project-try-csharp (dir)
  (if-let ((root
            (locate-dominating-file
             dir (lambda (dir)
                   (directory-files dir nil "\\.sln$" t 1)))))
      (cons 'csharp root)))

(add-hook 'project-find-functions #'my/project-try-csharp)

(require 'haskell-doc)
(use-package yaml-mode)

(use-package restclient
  :ensure t
  :mode ("\\.http\\'" . restclient-mode))

(use-package tex-mode
  :init
  (add-hook 'tex-mode-hook 'auto-fill-mode))

(use-package sql
  :mode ("\\.sql\\'" . sql-mode))

(use-package lsp-sourcekit
  :after lsp-mode
  :config
  (setq lsp-sourcekit-executable "/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp"))


(use-package swift-mode
  :hook (swift-mode . (lambda () (lsp))))

(electric-indent-mode t)

;; go lang - BEGIN

(require 'lsp-mode)
(add-hook 'go-mode-hook #'lsp-deferred)

;; somehow this keeps exiting with error code 2
(setq lsp-disabled-clients '(semgrep-ls))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(add-hook 'python-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'java-mode-hook #'lsp)

(setq-default flycheck-disabled-checkers '(python-pylint python-flake8))
(use-package flymake-ruff
  :ensure t
  :hook (python-mode . flymake-ruff-load))  ;; ruff should be installed

(provide 'my-prog-modes)
