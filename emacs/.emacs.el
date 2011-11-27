;; Add color to a shell running in emacs 'M-x shell'
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(current-language-environment "UTF-8")
 '(ecb-mouse-click-destination (quote last-point))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(comint-highlight-prompt ((t (:foreground "black")))))

(global-set-key (kbd "C-x t") 'goto-line) ; Ctrl + x  t

(iswitchb-mode 1)
(put 'narrow-to-region 'disabled nil)
(winner-mode t)


					; Add cmake listfile names to the mode list.
(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))

(autoload 'cmake-mode "~/.emacs.d/cmake-mode.el" t)

(defun cmake-rename-buffer ()
  "Renames a CMakeLists.txt buffer to cmake-<directory name>."
  (interactive)
					;(print (concat "buffer-filename = " (buffer-file-name)))
					;(print (concat "buffer-name     = " (buffer-name)))
  (when (and (buffer-file-name) (string-match "CMakeLists.txt" (buffer-name)))
					;(setq file-name (file-name-nondirectory (buffer-file-name)))
    (setq parent-dir (file-name-nondirectory (directory-file-name (file-name-directory (buffer-file-name)))))
					;(print (concat "parent-dir = " parent-dir))
    (setq new-buffer-name (concat "cmake-" parent-dir))
					;(print (concat "new-buffer-name= " new-buffer-name))
    (rename-buffer new-buffer-name t)
    )
  )

(add-hook 'cmake-mode-hook (function cmake-rename-buffer))


;;enable linum
(global-linum-mode 1)

;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; (load-file "/usr/src/cedet-1.0pre6/common/cedet.el")


;; Enable EDE (Project Management) features
;; (global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
;; (semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;; (semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)

;; (add-to-list 'load-path
;; 	     "/usr/src/ecb-2.40")

;; (require 'ecb-autoloads)

;;(global-set-key (kbd "M-/") 'hippie-expand)

;; (defun h-file-create ()
;;   "Create a new h file.  Insert a infdef/define/endif block"
;;   (interactive)
;;   (if (or (equal (substring (buffer-name (current-buffer)) -2 ) ".h")
;; 	  (substring (buffer-name (current-buffer)) -4 ) ".hpp"))
;;   (if (equal "" (buffer-string))
;;       (insert "#ifndef "(upcase (substring (buffer-name (current-buffer)) 0 -2)) "_H\n#define "
;;       (upcase (substring (buffer-name (current-buffer)) 0 -2)) "_H\n\n#endif"))))

;; (defun c-file-enter ()
;;   "Expands all member functions in the corresponding .h file"
;;   (interactive)
;;   (let ((c-file (buffer-name))
;;         (h-file (concat (substring (buffer-name (current-buffer)) 0 -3 ) "h")))
;;     (if (equal (substring (buffer-name (current-buffer)) -4 ) ".cpp")
;;         (if (file-exists-p h-file)
;;	    (expand-member-functions h-file c-file)))))

(setq c-mode-hook
      (function (lambda ()
		  (setq indent-tabs-mode nil)
		  (setq c-basic-offset 4))))

(setq c++-mode-hook
      (function (lambda ()
		  (setq indent-tabs-mode nil)
		  (setq c-basic-offset 4))))

(c-set-offset 'substatement-open 0)

(require 'whitespace)
(autoload 'global-whitespace-mode "whitespace" "Toggle whitespace visualization." t)
(global-whitespace-mode 1)
(autoload 'whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options." t)
(setq whitespace-line-column 160)

(setq auto-mode-alist
      (append
       '((".h\\'" . c++-mode))
       auto-mode-alist))

(setq auto-mode-alist
      (append
       '((".ipp\\'" . c++-mode))
       auto-mode-alist))

;; (shell "*shell5*")
;; (with-current-buffer "*shell5*"
;; (goto-char (point-max))
;; (insert "audacious")
;; (comint-send-input nil t))

;;(let ((default-directory "/usr/src/"))
;;  (shell "*shell1*"))

;; (load-file "/home/coelho/.emacs.d/column-marker.el")
;; (require 'column-marker)

(global-set-key (kbd "C-x C-o") 'ff-find-other-file)

(load "~/Downloads/src/haskell/haskellmode-emacs/haskell-site-file")

(autoload 'color-theme "~/.emacs.d/color-theme.el" t)
(setq color-theme-is-global t)
(setq color-theme-robin-hood t)

(prefer-coding-system 'utf-8)

;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;;(add-hook 'c-mode-common-hook 'google-set-c-style)