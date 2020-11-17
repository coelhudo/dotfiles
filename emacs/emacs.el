(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(alert-default-style 'message)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-safe-themes
   '("8b58ef2d23b6d164988a607ee153fd2fa35ee33efc394281b1028c2797ddeebb" "6731049cee8f7cbd542d7b3e1c551f3fab716a92119bd7c77f0bd1ef20849fb8" "85d1dbf2fc0e5d30f236712b831fb24faf6052f3114964fdeadede8e1b329832" "fa2af0c40576f3bde32290d7f4e7aa865eb6bf7ebe31eb9e37c32aa6f4ae8d10" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" "2642a1b7f53b9bb34c7f1e032d2098c852811ec2881eec2dc8cc07be004e45a0" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "13a8eaddb003fd0d561096e11e1a91b029d3c9d64554f8e897b2513dbf14b277" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "947190b4f17f78c39b0ab1ea95b1e6097cc9202d55c73a702395fc817f899393" "cdb4ffdecc682978da78700a461cdc77456c3a6df1c1803ae2dd55c59fa703e3" "4e753673a37c71b07e3026be75dc6af3efbac5ce335f3707b7d6a110ecb636a3" default))
 '(dired-dwim-target t)
 '(display-line-numbers-mode t t)
 '(ein:output-area-inlined-images t)
 '(electric-indent-mode nil)
 '(electric-pair-mode t)
 '(elpy-company-post-completion-function 'ignore)
 '(explicit-bash-args '("--noediting" "--login" "-i"))
 '(flycheck-emacs-lisp-load-path nil)
 '(inhibit-startup-screen t)
 '(ispell-dictionary "en_CA")
 '(jedi:environment-root "jedi")
 '(jedi:environment-virtualenv '("python" "-m" "venv"))
 '(json-reformat:indent-width 2)
 '(lsp-enable-on-type-formatting nil)
 '(lsp-ui-doc-position 'top)
 '(magit-diff-use-overlays nil)
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/")))
 '(package-selected-packages
   '(yasnippet-snippets gdscript-mode bufler chess unicode-fonts projectile-direnv direnv smartparens expand-region lsp-ui flycheck-clang-analyzer cmake-mode company-jedi mw-thesaurus flycheck-mypy nov ansi package-build shut-up epl git commander f dash s helm-projectile helm-org-rifle which-key skewer-mode charmap web-mode tern-auto-complete company-tern js2-refactor xref-js2 moz dispwatch ein jsx-mode react-snippets js-react-redux-yasnippets tide tss typescript-mode python-pytest monokai-theme atom-dark-theme solarized-theme lsp-mode swiper helm-gitlab gitlab org-analyzer org-cal fill-column-indicator org-re-reveal-ref org-ref crontab-mode org-alert org-pomodoro git-timemachine elpy csv-mode multiple-cursors magit haskell-mode jedi pytest pyvenv yaml-mode yasnippet use-package flycheck json-mode markdown-mode+ zenburn-theme))
 '(python-environment-virtualenv '("python" "-m" "venv" "--system-site-packages"))
 '(pyvenv-virtualenvwrapper-python "/usr/bin/python")
 '(shell-file-name "/bin/zsh")
 '(show-paren-mode t)
 '(tls-checktrust t)
 '(tool-bar-mode nil)
 '(tramp-default-method "ssh")
 '(web-mode-enable-auto-expanding t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((t (:underline "#F92672" :weight bold))))
 '(flycheck-warning ((t (:underline "#FD971F" :weight bold))))
 '(org-level-1 ((t (:inherit default :foreground "#FD971F" :height 1.1))))
 '(org-level-2 ((t (:inherit default :foreground "#A6E22E" :height 1.1))))
 '(org-level-3 ((t (:inherit default :foreground "#66D9EF" :height 1.1))))
 '(org-level-4 ((t (:inherit default :foreground "#E6DB74" :height 1.1)))))

(add-to-list 'default-frame-alist
	     '(font . "Cascadia Mono-11"))
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))

(package-initialize)
(package-install-selected-packages)
(defvar settings-dir
  (expand-file-name "settings" user-emacs-directory))
(add-to-list 'load-path settings-dir)

(require 'my-org)
(require 'my-python)
(require 'my-markdown)
(require 'my-js)
(require 'my-web)
(require 'my-c_cpp)
(require 'my-web)

(load-theme 'monokai t)
(global-set-key (kbd "C-x c") 'mc/edit-lines)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-=") 'er/expand-region)
(add-hook 'before-save-hook 'whitespace-cleanup)

(defun crontab-e ()
  "Run `crontab -e' in a emacs buffer."
  (interactive)
  (with-editor-async-shell-command "crontab -e"))

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
	(exchange-point-and-mark))
    (let ((column (current-column))
	  (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
	(transpose-lines arg))
      (forward-line -1)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(global-set-key [\M-\S-up] 'move-text-up)
(global-set-key [\M-\S-down] 'move-text-down)

(use-package unicode-fonts
   :ensure t
   :config
    (unicode-fonts-setup))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))

(use-package helm-projectile
  :ensure t
  :config (helm-projectile-on))

(use-package which-key
  :ensure t
  :config (which-key-mode 1))

;; (use-package auto-complete
;;   :ensure t
;;   :init
;;   (progn
;;     (ac-config-default)
;;     (global-auto-complete-mode t)
;;     ))

(use-package yasnippet
  :ensure t
  :init (add-hook 'prog-mode-hook #'yas-minor-mode)
  :config (yas-reload-all))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)

  (global-company-mode t))



(use-package lsp-mode
  :ensure t
  :commands lsp
  :custom
  (lsp-prefer-flymake nil)
  :hook ((c++-mode c-mode) . lsp))

(use-package lsp-ui
  :after lsp-mode
  :diminish
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-delay 1)
  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-position 'top))

(use-package tex-mode
  :init
  (add-hook 'tex-mode-hook 'auto-fill-mode))

(setq search-default-mode #'char-fold-to-regexp)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-r") 'swiper-backward)

(setq confirm-kill-emacs 'yes-or-no-p)

(defun change-font-size (new-size)
  "Change the font size to the given value"
  (interactive "nNew font size: ")
  (set-face-attribute 'default nil :height (* 10 new-size)))

(defun my/check-monitor ()
 (change-font-size
   (if (eq (cadr (cadr (frame-monitor-attributes))) 1920) 9 13)))

(run-with-idle-timer 5 1 'my/check-monitor)

;; (defun setup-tide-mode ()
;;   (interactive)
;;   (tide-setup)
;;   (flycheck-mode +1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1)
;;   ;; company is an optional dependency. You have to
;;   ;; install it separately via package-install
;;   ;; `M-x package-install [ret] company`
;;   (company-mode +1))

;; aligns annotation to the right hand side
;;(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)

;; (add-hook 'typescript-mode-hook #'setup-tide-mode)

;;; .emacs.el ends here
