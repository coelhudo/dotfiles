(require 'org)
(require 'alert)
(setq org-default-notes-file (concat org-directory "/notes.org"))

(add-to-list 'alert-user-configuration '(((:category . "org-pomodoro")) libnotify nil))

(setq org-pomodoro-play-sounds nil)

(provide 'my-org)
