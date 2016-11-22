;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("4e753673a37c71b07e3026be75dc6af3efbac5ce335f3707b7d6a110ecb636a3" default)))
 '(inhibit-startup-screen t)
 '(jedi:environment-virtualenv (quote ("conda" "create" "-y" "-n")))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (android-mode yaml-mode yasnippet use-package flycheck json-mode markdown-mode+)))
 '(show-paren-mode t)
 '(tls-checktrust t)
 '(current-language-environment "UTF-8")
 '(inhibit-startup-screen t)
 '(tool-bar-mode nil)
 '(column-number-mode t)
 '(global-linum-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defvar settings-dir
  (expand-file-name "settings" user-emacs-directory))
(add-to-list 'load-path settings-dir)

(require 'my-python)
(require 'my-org)
(require 'my-markdown)

(load-theme 'zenburn t)
(global-set-key (kbd "C-x t") 'goto-line)
(add-hook 'before-save-hook 'whitespace-cleanup)
