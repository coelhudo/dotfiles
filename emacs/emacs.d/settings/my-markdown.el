(setq auto-mode-alist
      (append
       '(("CMakeLists\\.md\\'" . markdown-mode))
       '(("\\.text\\'" . markdown-mode))
       '(("\\.markdown\\'" . markdown-mode))
       auto-mode-alist))

;;(autoload 'markdown-mode "~/.emacs.d/markdown-mode.el" t)

(provide 'my-markdown)
