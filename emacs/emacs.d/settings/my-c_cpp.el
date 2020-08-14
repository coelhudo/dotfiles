(setq c-mode-hook

      (function (lambda ()
		  (setq indent-tabs-mode nil)
		  (setq c-basic-offset 4))))

(setq c++-mode-hook
      (function (lambda ()
		  (setq indent-tabs-mode nil)
		  (setq c-basic-offset 4))))

(c-set-offset 'substatement-open 0)


;; CMake stuff
(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))

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

(global-set-key (kbd "C-x C-o") 'ff-find-other-file)

(provide 'my-c_cpp)
