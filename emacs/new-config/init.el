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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives
   '(("elpa" . "https://elpa.gnu.org/packages/")
     ("org-contrib" . "https://elpa.nongnu.org/nongnu/")
     ("melpa" . "http://melpa.org/packages/")))
 '(package-selected-packages '(vertico cape magit transient org-roam)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; package management
(package-install-selected-packages)

;; enable magit and its sub-packages
(use-package magit
  :ensure t)
(use-package magit-status)
(use-package magit-extras)
(use-package magit-ediff)

(require 'org-mode-settings)
(require 'code-agnostic-configuration)
