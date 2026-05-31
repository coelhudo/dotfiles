;; disable some of the UI
(setq inhibit-startup-message t)
(tool-bar-mode -1)
;; remember closed files
(recentf-mode 1)
;; minibuffer
(setq history-length 25)
(savehist-mode 1)
;; remember cursor of opened file
(save-place-mode 1)
;; refresh buffer
(global-auto-revert-mode 1)
;; refresh non file buffers
(setq global-auto-revert-non-file-buffers t)
(setq confirm-kill-emacs 'yes-or-no-p)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives
   '(("elpa" . "https://elpa.gnu.org/packages/")
     ("org-contrib" . "https://elpa.nongnu.org/nongnu/")
     ("melpa" . "http://melpa.org/packages/")))
 '(package-selected-packages nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; theme and font
(load-theme 'monokai t)

(add-to-list 'default-frame-alist
             '(font . "Cascadia Mono-11"))
(set-face-attribute 'mode-line nil :font "Cascadia Mono-10")
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))

;; package management
(package-install-selected-packages)

;; enable magit and its sub-packages
(use-package magit
  :ensure t)
(use-package magit-status)
(use-package magit-extras)
(use-package magit-ediff)

;; enable which-key
(use-package which-key
  :diminish
  :ensure t
  :config (which-key-mode 1))

;; enable multiple cursors
(use-package multiple-cursors
  :ensure t)

;; disable bi-directional scanning (for languages that are from right to left)
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; save clipboard before kill
(setq save-interprogram-paste-before-kill t)

;; load modules
(require 'org-mode-settings)
(require 'code-agnostic-configuration)
(require 'code-configuration)
