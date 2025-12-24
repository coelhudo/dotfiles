(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(alert-default-style 'message)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-safe-themes
   '("b49f66a2e1724db880692485a5d5bcb9baf28ed2a3a05c7a799fa091f24321da"
     "c7fd1708e08544d1df2cba59b85bd25263180b19b287489d4f17b9118487e718"
     "d9646b131c4aa37f01f909fbdd5a9099389518eb68f25277ed19ba99adeb7279"
     "e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9"
     "8b58ef2d23b6d164988a607ee153fd2fa35ee33efc394281b1028c2797ddeebb"
     "6731049cee8f7cbd542d7b3e1c551f3fab716a92119bd7c77f0bd1ef20849fb8"
     "85d1dbf2fc0e5d30f236712b831fb24faf6052f3114964fdeadede8e1b329832"
     "fa2af0c40576f3bde32290d7f4e7aa865eb6bf7ebe31eb9e37c32aa6f4ae8d10"
     "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088"
     "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476"
     "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9"
     "2642a1b7f53b9bb34c7f1e032d2098c852811ec2881eec2dc8cc07be004e45a0"
     "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773"
     "13a8eaddb003fd0d561096e11e1a91b029d3c9d64554f8e897b2513dbf14b277"
     "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1"
     "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5"
     "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3"
     "947190b4f17f78c39b0ab1ea95b1e6097cc9202d55c73a702395fc817f899393"
     "cdb4ffdecc682978da78700a461cdc77456c3a6df1c1803ae2dd55c59fa703e3"
     "4e753673a37c71b07e3026be75dc6af3efbac5ce335f3707b7d6a110ecb636a3" default))
 '(dired-dwim-target t)
 '(display-line-numbers-mode t t)
 '(electric-indent-mode nil)
 '(electric-pair-mode t)
 '(explicit-bash-args '("--noediting" "--login" "-i"))
 '(fill-column 88)
 '(gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(ispell-dictionary "en_CA")
 '(json-reformat:indent-width 2)
 '(lsp-disabled-clients '(semgrep-ls ruff))
 '(lsp-enable-on-type-formatting nil)
 '(lsp-pylsp-plugins-flake8-enabled nil)
 '(lsp-pylsp-plugins-jedi-completion-enabled t)
 '(lsp-pylsp-plugins-mypy-enabled t)
 '(lsp-pylsp-plugins-ruff-enabled t)
 '(lsp-pylsp-plugins-ruff-ignore ["D100"])
 '(magit-diff-use-overlays nil)
 '(package-archives
   '(("elpa" . "https://elpa.gnu.org/packages/")
     ("org-contrib" . "https://elpa.nongnu.org/nongnu/")
     ("melpa" . "http://melpa.org/packages/")))
 '(package-selected-packages
   '(csharp-mode restclient-mode arduino-mode restclient-jq ob-restclient eslint-fix
                 pug-mode haskell-mode add-node-modules-path vertico go-mode
                 docker-compose-mode org-roam jest dockerfile-mode imenu-list
                 superword-mode lsp-ui magit yaml-mode org-ref python-test swiper
                 doom-modeline keychain-environment tramp-container lorem-ipsum
                 exec-path-from-shell diminish command-log-mode editorconfig undo-tree
                 threes 2048-game rjsx-mode lsp-java yasnippet-snippets gdscript-mode
                 bufler chess unicode-fonts projectile-direnv direnv smartparens
                 expand-region flycheck-clang-analyzer cmake-mode mw-thesaurus
                 flycheck-mypy ansi package-build shut-up epl git commander
                 helm-projectile helm-org-rifle which-key skewer-mode charmap web-mode
                 tern-auto-complete js2-refactor xref-js2 moz dispwatch
                 js-react-redux-yasnippets tss typescript-mode atom-dark-theme
                 solarized-theme helm-gitlab gitlab org-analyzer org-cal
                 fill-column-indicator crontab-mode org-pomodoro git-timemachine
                 csv-mode pytest yasnippet use-package markdown-mode+ monokai-theme
                 python-pytest corfu))
 '(python-environment-virtualenv '("python" "-m" "venv" "--system-site-packages"))
 '(pyvenv-virtualenvwrapper-python "/usr/bin/python")
 '(ring-bell-function 'ignore)
 '(shell-file-name "/bin/zsh")
 '(show-paren-mode t)
 '(tls-checktrust t)
 '(tool-bar-mode nil)
 '(tramp-default-method "ssh")
 '(web-mode-enable-auto-expanding t))


(add-to-list 'default-frame-alist
             '(font . "Cascadia Mono-12"))
(set-face-attribute 'mode-line nil :font "Cascadia Mono-10")
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))

;; (eval-when-compile
;;   ;; Following line is not needed if use-package.el is in ~/.emacs.d
;;   (add-to-list 'load-path "~/.emacs.d/elpa")
;;   (require 'use-package))

(package-initialize)
(package-install-selected-packages)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure nil)

(use-package expand-region
  :ensure t)

(use-package restclient
  :ensure t)

(use-package magit
  :ensure t)
(use-package magit-status)
(use-package magit-extras)
(use-package magit-ediff)
(use-package git-rebase)

(use-package flycheck
  :init
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (setq flycheck-javascript-eslint-executable nil)
  :custom-face
  (flycheck-error ((t (:underline "#F92672" :weight bold))))
  (flycheck-warning ((t (:underline "#FD971F" :weight bold))))
  :config
  (global-flycheck-mode t))

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t)
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

(defvar settings-dir
  (expand-file-name "settings" user-emacs-directory))
(add-to-list 'load-path settings-dir)

(require 'diminish)
(require 'my-ui-enhancement)
(require 'my-custom-functions)
(require 'my-lsp)
(require 'my-org)
(require 'my-markdown)
(require 'my-web)
(require 'my-c_cpp)
(require 'my-prog-modes)

(load-theme 'monokai t)
(add-hook 'before-save-hook 'whitespace-cleanup)

(require 'multiple-cursors)
(global-set-key (kbd "C-x c") 'mc/edit-lines)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-unset-key (kbd "s-t")) ;; macOS specific

(setq undo-tree-visualizer-diff t)

(require 'treemacs)
(require 'treemacs-mouse-interface)

(defun crontab-e ()
  "Run `crontab -e' in a Emacs buffer."
  (interactive)
  (with-editor-async-shell-command "crontab -e"))

;; (use-package ido
;;   :custom
;;   ((ido-enable-flex-matching t)
;;    (ido-everywhere t))
;;   :config
;;   (ido-mode 1))

(use-package autorevert
  :diminish
  :ensure t
  :config (auto-revert-mode 1))

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

(use-package command-log-mode)

(use-package unicode-fonts
  :ensure t
  :config
  (unicode-fonts-setup))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode 1)
  (setq projectile-enable-caching t))

;; (use-package helm-projectile
;;   :ensure t
;;   :config (helm-projectile-on))

(use-package which-key
  :diminish
  :ensure t
  :config (which-key-mode 1))

(setq search-default-mode #'char-fold-to-regexp)

(setq confirm-kill-emacs 'yes-or-no-p)

(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; need to execute nerd-icons
(use-package doom-modeline
  :ensure t
  :config (doom-modeline-mode 1)
  :custom
  (find-file-visit-truename t)
  (doom-modeline-height 12)
  (doom-modeline-bar-width 4)
  (doom-modeline-window-width-limit 60))

(use-package docker-compose-mode)
(use-package json-mode)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(use-package lorem-ipsum
  :bind (("C-c C-l s" . lorem-ipsum-insert-sentences)
         ("C-c C-l p" . lorem-ipsum-insert-paragraphs)
         ("C-c C-l l" . lorem-ipsum-insert-list))
  )

(require 'dired )
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory

;;; .emacs.el ends here
(put 'dired-find-alternate-file 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=clang-format"))
                  )))

(add-hook 'prog-mode 'format-all-mode)

(server-start)
