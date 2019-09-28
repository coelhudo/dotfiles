;;; my-org --- org-mode related conf

;;; Commentary:
(require 'org)
(require 'alert)
(require 'org-ref)

;;; Code:
(org-babel-do-load-languages 'org-babel-load-languages '((latex . t)))
(setq org-latex-pdf-process (list "latexmk -pdf -f %f -output-directory=%o"))

(add-to-list 'alert-user-configuration '(((:category . "org-pomodoro")) libnotify nil))

(use-package org-mode
  :bind (("C-c l" . org-store-link)
	 ("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
	 ("C-c b" . org-switchb)))

(setq org-agenda-files (list "~/Dropbox/TODO/"))
(setq org-capture-templates
      '(("a" "Appointment" entry (file "~/Dropbox/TODO/gcal.org")
	 "\n* %?\n:PROPERTIES:\n:calendar-id: coelhudo@gmail.com\n:END:\n:org-gcal:\n%^T\n:END:\n")
	("t" "Todo" entry (file+headline "~/Dropbox/TODO/TODO.org" "Backlog")
	 "** TODO %?\n" :prepend t)
	("n" "Notes" entry (file "~/Dropbox/TODO/notes.org")
	 "* %?\n%u" :prepend t)))

(setq org-todo-keywords
  '((sequence "TODO(t)" "CURRENT(c)" "WAITING(w)" "|" "DONE(d)")))
(setq org-todo-keyword-faces
      '(("TODO" . "indian red") ("CURRENT" . "yellow")
	("WAITING" . "#C0C0C0")
	("DONE" . "medium spring green")))



(use-package org-pomodoro
  :bind (("M-p" . org-pomodoro))
  :config
  (setq org-pomodoro-play-sounds nil))


(provide 'my-org)
;;; my-org ends here
