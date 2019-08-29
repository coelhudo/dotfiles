(require 'org)
(require 'alert)
(require 'org-ref)

;;; Code:
(setq org-latex-pdf-process (list "latexmk -pdf -f %f -output-directory=%o"))

(add-to-list 'alert-user-configuration '(((:category . "org-pomodoro")) libnotify nil))

(use-package org-mode
  :bind (("C-c l" . org-store-link)
	 ("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
	 ("C-c b" . org-switchb))
  :config
  (setq org-agenda-files "~/Dropbox/TODO/gcal.org"))

(setq org-capture-templates
      '(("a" "Appointment" entry (file "~/Dropbox/TODO/gcal.org")
	 "* %?\n:PROPERTIES:\n:calendar-id: coelhudo@gmail.com\n:END:\n:org-gcal:\n%^T\n:END:\n")
	("t" "Todo" entry (file+headline "~/Dropbox/TODO/TODO.org" "Backlog")
	 "** TODO %?\n%u" :prepend t)
	("n" "Notes" entry (file "~/Dropbox/TODO/notes.org")
	 "* %?\n%u" :prepend t)))


(use-package org-pomodoro
  :bind (("M-p" . org-pomodoro))
  :config
  (setq org-pomodoro-play-sounds nil))


(provide 'my-org)
;;; my-org ends here
