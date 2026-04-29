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
		
