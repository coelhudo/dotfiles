;;; my-org --- org-mode related conf

;;; Commentary:
(require 'org)
(require 'alert)
(require 'org-ref)
(require 'helm-org-rifle)

;;; Code:
(org-babel-do-load-languages 'org-babel-load-languages '((latex . t)
							 (python . t)))
(setq org-latex-pdf-process (list "latexmk -pdf -f %f -output-directory=%o"))

(use-package ob-python
  :after org
  :init
  (setq org-babel-python-command "python3"))

(add-to-list 'alert-user-configuration '(((:category . "org-pomodoro")) libnotify nil))

(add-to-list 'load-path "~/dev/ikiwiki-org-plugin/lisp")

(use-package org-mode
  :init
  (add-hook 'org-mode-hook 'turn-on-auto-fill)
  (add-hook 'org-mode-hook 'flyspell-mode)
  (add-hook 'org-mode-hook '(lambda ()(setq fill-column 90)))
  :bind (("C-c l" . org-store-link)
	 ("C-c a" . org-agenda)
	 ("C-c c" . org-capture)
	 ("C-c b" . org-switchb)))

(setq org-agenda-files (list "~/Dropbox/TODO/"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Dropbox/TODO/TODO.org" "Backlog")
	 "** TODO %?\n" :prepend t)
	("n" "Notes" entry (file "~/Dropbox/TODO/notes.org")
	 "* %?\n%u" :prepend t)))

(setq org-todo-keywords
  '((sequence "TODO(t)" "CURRENT(c)" "WAITING(w)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(a)")))
(setq org-todo-keyword-faces
      '(("TODO" . "indian red")
	("CURRENT" . "yellow")
	("WAITING" . "#a020f0")
	("NEXT" . "#00ced1")
	("DONE" . "#228b22")
	("CANCELLED" . "#a9a9a9")))

(fset 'create-bibsection
   [?* ?* ?  ?T return ?  ?  ?  ?- ?  ?\\ ?t ?e ?x ?t ?t ?t ?\{ ?\C-f return tab ?< ?s tab ?b ?i ?b ?t ?e ?x ?\C-n ?\C-n return return ?* ?* ?* ?  ?J ?u ?s ?t ?i ?f ?i ?c ?a ?t ?i ?o ?n return return ?* ?* ?* ?  ?M ?e ?t ?h ?o ?d return return ?* ?* ?* ?  ?E ?v ?a ?l ?u ?a ?t ?i ?o ?n ?  ?a ?n ?d ?  ?C ?o ?n ?c ?l ?u ?s ?i ?o ?n])



(use-package org-pomodoro
  :bind (("M-p" . org-pomodoro))
  :config
  (setq org-pomodoro-play-sounds nil))


(provide 'my-org)
;;; my-org ends here
