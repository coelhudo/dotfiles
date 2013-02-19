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
(ido-mode t)


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

(global-linum-mode 1)

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

(global-set-key (kbd "C-x C-o") 'ff-find-other-file)

;;(load "~/Downloads/src/haskell/haskellmode-emacs/haskell-site-file")

(autoload 'color-theme "~/.emacs.d/color-theme.el" t)
(setq color-theme-is-global t)
(setq color-theme-robin-hood t)

(prefer-coding-system 'utf-8)
