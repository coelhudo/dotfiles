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
  (add-hook 'org-mode-hook #'(lambda ()(setq fill-column 90)))
  :config
  (setq org-image-actual-width nil)
  (setq org-hide-emphasis-markers t)
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c b" . org-switchb))
  :custom-face
  (org-level-1 ((t (:inherit default :foreground "#FD971F" :height 1.1))))
  (org-level-2 ((t (:inherit default :foreground "#A6E22E" :height 1.1))))
  (org-level-3 ((t (:inherit default :foreground "#66D9EF" :height 1.1))))
  (org-level-4 ((t (:inherit default :foreground "#E6DB74" :height 1.1)))))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/dev/org_roam_notes")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-db-autosync-enable))

(use-package org-roam-mode)

;;; GTD configuration from here:
;;; https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html
;; (setq org-agenda-files (directory-files-recursively "~/Dropbox/TODO" "\\.org$"))
(setq org-agenda-files (directory-files-recursively "~/dev/org_roam_notes" "\\.org$"))

(setq org-tag-alist '((:startgrouptag)
                      ("@phd" . ?p)
                      (:grouptags)
                      ("writing" . ?r) ("arps" . ?a) ("dcpoc" . ?d) ("ta" . ?t)
                      (:endgrouptag)
                      (:startgrouptag)
                      ("@life" . ?l)
                      (:grouptags)
                      ("opensource" . ?o) ("study" . ?s) ("financial" . ?f)
                      ("errands". ?e) ("tech_issues" . ?i)
                      (:startgrouptag)
                      ("@work" . ?w)
                      (:grouptags)
                      ("study". ?y)
                      (:endgrouptag)
                      ))

(setq org-agenda-custom-commands
      '(
        ("p" "PhD tasks" tags-todo "@phd"
         ((org-agenda-overriding-header "PhD")))
        ("l" "Life related tasks" tags-todo "@life"
         ((org-agenda-overriding-header "Life")))
        ))

;; (setq org-refile-targets '(("~/Dropbox/TODO/gtd.org" :maxlevel . 3)
;;                            ("~/Dropbox/TODO/someday.org" :level . 1)
;;                            ("~/Dropbox/TODO/tickler.org" :maxlevel . 2)))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Dropbox/TODO/inbox.org" "Inbox")
         "* TODO %?\n" :prepend t)
        ("T" "Tickler" entry (file "~/Dropbox/TODO/tickler.org") "** %? \n" )));;; insert deadline keyword here

(setq org-todo-keywords
  '((sequence "TODO(t)" "CURRENT(c)" "WAITING(w)" "NEXT(n)" "|" "DONE(d)" "CANCELLED(a)")))

(setq org-todo-keyword-faces
      '(("TODO" . "indian red")
        ("CURRENT" . "yellow")
        ("WAITING" . "#a020f0")
        ("NEXT" . "#00ced1")
        ("DONE" . "#228b22")
        ("CANCELLED" . "#a9a9a9")))

;;TODO: make a proper function using elisp.
(fset 'create-bibsection
   [?* ?* ?  ?T return ?  ?  ?  ?- ?  ?\\ ?t ?e ?x ?t ?t ?t ?\{ ?\C-f return tab ?< ?s tab ?b ?i ?b ?t ?e ?x ?\C-n ?\C-n return return ?* ?* ?* ?  ?J ?u ?s ?t ?i ?f ?i ?c ?a ?t ?i ?o ?n return return ?* ?* ?* ?  ?M ?e ?t ?h ?o ?d return return ?* ?* ?* ?  ?E ?v ?a ?l ?u ?a ?t ?i ?o ?n ?  ?a ?n ?d ?  ?C ?o ?n ?c ?l ?u ?s ?i ?o ?n])

(use-package org-pomodoro
  :bind (("M-p" . org-pomodoro))
  :config
  (setq org-pomodoro-play-sounds nil))


(provide 'my-org)

;;; my-org.el ends here
