(use-package haskell-mode
  :mode "\\.hs\\'")

(use-package arduino-mode
  :mode "\\.ino\\'")

(use-package csharp-mode
  :ensure t
  :mode "\\.cs\\'"
  :init
  (defun my/csharp-mode-hook ()
    (setq-local lsp-auto-guess-root t)
    (lsp))
  (add-hook 'csharp-mode-hook #'my/csharp-mode-hook))

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


(if (eq system-type 'darwin)
    (setenv "FrameworkPathOverride" "/Library/Frameworks/Mono.framework/Versions/Current/Commands/"))


(require 'haskell-doc)
(use-package yaml-mode)

(use-package restclient
  :ensure t
  :mode ("\\.http\\'"))

(use-package tex-mode
  :init
  (add-hook 'tex-mode-hook 'auto-fill-mode))


(provide 'my-prog-modes)
