(package-initialize)
(package-install-selected-packages)
(setq package-install-upgrade-built-in t)

(defvar settings-dir
  (expand-file-name "settings" user-emacs-directory))
(add-to-list 'load-path settings-dir)
