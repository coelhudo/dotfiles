;; Do not modify this file. Modify init.org and call the function org-babel-tangle

;; initialize package
(package-initialize)
(setq package-install-upgrade-built-in t)

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

;; custom variables
(custom-set-variables
 '(package-archives
 '(("elpa" . "https://elpa.gnu.org/packages/")
   ("org-contrib" . "https://elpa.nongnu.org/nongnu/")
   ("melpa" . "http://melpa.org/packages/")))
 '(package-selected-packages '()) ;; list of packages that will grow as ensure: directive is used with use-package
 '(show-paren-mode t) ;; show balanced parathesis
 '(electric-indent-mode nil) ;; toggle automatic reindentation mode
 '(electric-pair-mode t) ;; toggle automatic parenthesis pairs
 )

;; COmpletion in Region FUnction
(use-package corfu
  :ensure t
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  (corfu-quit-at-boundary 'separator)   ;; Never quit at completion boundary (original value: (corfu-quit-at-boundary nil) )
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))

(add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)

;; A few more useful configurations...
(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentationcompletion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

;; Add completion-at-point extensions
(use-package cape
  :ensure t
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
)

;; complete for corfu
(defun my/eglot-capf ()
  (setq-local completion-at-point-functions
		(list (cape-capf-super
		       #'eglot-completion-at-point
		       #'cape-dabbrev
		       #'cape-file))))

(add-hook 'eglot-managed-mode-hook #'my/eglot-capf)

;; this adds a language server for c++.
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
		 '(c++-mode . "ccls")))

;; VERTical Interactive COmpletion
(use-package vertico
  :ensure t
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t)
  )

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
	   ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

;; Helps find match using regex
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless partial-completion basic)
	completion-category-defaults nil
	completion-category-overrides nil))

;; Rest client
(use-package verb
  :ensure t)

;; Org configuration
(use-package org
  :ensure t
  :init
  (add-hook 'org-mode-hook 'turn-on-auto-fill)
  (add-hook 'org-mode-hook #'(lambda ()(setq fill-column 90)))
  :config
  (setq org-image-actual-width nil)
  (setq org-hide-emphasis-markers t)
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map) ;; for API testing
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c b" . org-switchb))
  :custom-face
  (org-level-1 ((t (:inherit default :foreground "#FD971F" :height 1.1))))
  (org-level-2 ((t (:inherit default :foreground "#A6E22E" :height 1.1))))
  (org-level-3 ((t (:inherit default :foreground "#66D9EF" :height 1.1))))
  (org-level-4 ((t (:inherit default :foreground "#E6DB74" :height 1.1)))))

;; Org roam
(use-package org-roam
:ensure t
:custom
(org-roam-directory "~/dev/org_roam_notes")
(org-roam-completion-everywhere t)
:bind (("C-c n l" . org-roam-buffer-toggle)
       ("C-c n f" . org-roam-node-find)
       ("C-c n i" . org-roam-node-insert)
       :map org-roam-dailies-map
       ("Y" . org-roam-dailies-capture-yesterday)
       ("T" . org-roam-dailies-capture-tomorrow))
:bind-keymap
("C-c n d" . org-roam-dailies-map)
:config
(require 'org-roam-dailies)
(org-roam-db-autosync-enable))

;; python virtual environment tracker
;; this detects .venv automatically
(use-package pet
  :ensure t
  :config
  (add-hook 'python-base-mode-hook 'pet-mode -10))

;; Ask before exiting
(setq confirm-kill-emacs 'yes-or-no-p)

;; Helps find keymaps
(use-package expand-region
  :ensure t)
(global-set-key (kbd "C-=") 'er/expand-region)

;; So we don't have to manually reload the buffer if somethings is changed
(use-package autorevert
  :diminish
  :ensure t
  :config (auto-revert-mode 1))

;; Multiple cursors
(use-package multiple-cursors
  :ensure t)

;; Disable bi-directional scanning (for languages that are from right to left)
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

(setq save-interprogram-paste-before-kill t)

(use-package magit
  :ensure t)
;; these below don't need the ensure directive since it is part of the magit package
(use-package magit-status)
(use-package magit-extras)
(use-package magit-ediff)

(use-package expand-region
  :ensure t)
(global-set-key (kbd "C-=") 'er/expand-region)

(package-install-selected-packages) ;; install packages

(load-theme 'monokai t) ;; for example
(add-to-list 'default-frame-alist
	       '(font . "Cascadia Mono-11"))
(set-face-attribute 'mode-line nil :font "Cascadia Mono-10")
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))
