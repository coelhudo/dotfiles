(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-safe-themes
   (quote
    ("4e753673a37c71b07e3026be75dc6af3efbac5ce335f3707b7d6a110ecb636a3" default)))
 '(explicit-bash-args (quote ("--noediting" "--login" "-i")))
 '(flycheck-emacs-lisp-load-path (quote load-path))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(jedi:environment-root "jedi")
 '(jedi:environment-virtualenv (quote ("python" "-m" "venv")))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (csv-mode multiple-cursors magit haskell-mode jedi pytest pyvenv android-mode yaml-mode yasnippet use-package flycheck json-mode markdown-mode+ zenburn-theme)))
 '(python-environment-virtualenv (quote ("python" "-m" "venv" "--system-site-packages")))
 '(python-shell-virtualenv-root "/home/coelho/dev/dcpoc/.venv/")
 '(pyvenv-virtualenvwrapper-python "/usr/bin/python")
 '(shell-file-name "/bin/zsh")
 '(show-paren-mode t)
 '(tls-checktrust t)
 '(tool-bar-mode nil)
 '(tramp-default-method "ssh" nil (tramp)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'default-frame-alist
	     '(font . "DejaVu Sans Mono-14"))

(package-initialize)
(package-install-selected-packages)
(defvar settings-dir
  (expand-file-name "settings" user-emacs-directory))
(add-to-list 'load-path settings-dir)

(require 'my-org)
(require 'my-python)
(require 'my-markdown)

(load-theme 'zenburn t)
(global-set-key (kbd "C-x t") 'goto-line)
(global-set-key (kbd "C-x c") 'mc/edit-lines)
(add-hook 'before-save-hook 'whitespace-cleanup)
;;; .emacs.el ends here
