(require 'org)
(require 'alert)
(require 'org-ref)
(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-latex-pdf-process (list "latexmk -pdf -f %f -output-directory=%o"))

(add-to-list 'alert-user-configuration '(((:category . "org-pomodoro")) libnotify nil))

(setq org-pomodoro-play-sounds nil)

(provide 'my-org)
