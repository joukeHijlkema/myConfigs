
(setq org-agenda-file-regexp "^[^#]*\\.org$")
(setq org-agenda-files (quote ("/home/hylkema/Documents/Org/Test.org")))
(setq org-agenda-skip-scheduled-if-done t)
(setq org-babel-load-languages (quote ((emacs-lisp . t) (shell . t))))
(setq org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "/usr/bin/masterpdfeditor4"))))
(setq org-log-done (quote note))
(setq org-support-shift-select t)

(require 'org-journal)
(setq org-agenda-files '("~/Documents/Org" "~/org"))

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(require 'subr-x)
(with-eval-after-load 'org
  (setq org-startup-indented t)
  (flyspell-mode)
  (visual-line-mode t))
(add-hook 'org-mode-hook 'turn-on-flyspell)

(if (boundp 'warning-suppress-types)
    (add-to-list 'warning-suppress-types' (yasnippet backquote-change))
  (setq warning-suppress-types '((yasnippet backquote-change))))

;; === Find all org files  ===
(load-library "find-lisp")
(setq org-agenda-files
   (find-lisp-find-files "/home/hylkema/Documents/Org" "\.org$"))


(setq jouke-re-action-simple "\\*\\*\\* \\(ACTION\\|CLOSED\\)")
(setq jouke-re-action-medium "\\*\\*\\* \\(CLOSED\\|ACTION\\).\\([0-9]*\\) *# *\\([^#]*\\) *# *resp *\\([^#]*\\) *# *\\([^#]*\\) *# *\\([^#]*\\)")
(setq jouke-re-action-complete "\\*\\*\\* \\(ACTION\\|CLOSED\\)\\([^:]+:.*\\)\\(\\([\n ]+CLOSED:.*\\)?\\([\n -]+CLOSING NOTE.*\\))?\\([\n ]+.*\\)?\\)?")
(defun jouke-count-actions ()
  "count the ACTION items in a document "
  (interactive)
  (save-excursion
    (setq ac 0)
    (setq case-fold-search nil)
    (goto-char (point-min))
    (while (re-search-forward jouke-re-action-simple (point-max) t)
      (setq ac (1+ ac)))
  (print ac)))

(defun jouke-move-actions ()
  "fill the action table"
  (interactive)
  (setq case-fold-search nil)
  (save-excursion
    ;; find the first action table insertion point and delete existing lines
    (when (search-forward "# ActionTable" (point-max) t)
      (forward-line 5)
      (beginning-of-line)
      (setq myStart (point))
      (when (re-search-forward "^|-+\+" (point-max) t)
	(beginning-of-line)
	(setq myEnd (point))
	(kill-region myStart myEnd)
	(dolist (elt (reverse (jouke-matches-in-buffer jouke-re-action-complete (point))))
	  (jouke-print-action elt))
	)
      )
    )
  )
    
  
(defun jouke-matches-in-buffer (regexp end &optional buffer)
  "return a list of matches of REGEXP in BUFFER or the current buffer if not given."
  (setq case-fold-search nil)
  (let ((matches))
    (save-excursion
      (save-match-data
	(with-current-buffer (or buffer (current-buffer))
	  (save-restriction
	    (widen)
	    (goto-char 1)
	    (while (search-forward-regexp regexp end t 1)
	      (push (match-string 0) matches)))))
      matches)))

(defun jouke-print-action (l)
  "format a table row from an action"
    (save-match-data
      (string-match jouke-re-action-medium l)
      (insert (format "|%s|%s|%s|%s|%s|%s|%s|\n"
		      (match-string 6 l)
		      (match-string 2 l)
		      (match-string 3 l)
		      (match-string 4 l)
		      (match-string 5 l)
		      (if (string= (match-string 1 l) "ACTION")
			  "O"
			"C")
		      (if (string= (match-string 1 l) "ACTION")
			  "-"
			(jouke-get-note-from-line l))))))

(defun jouke-get-note-from-line (l)
  "get the closing note from a line if it is there"
  (save-match-data
    (string-match jouke-re-action-complete l)
    (if (match-string 6 l)
	(string-trim (format "%s" (match-string 6 l)))
      "-")))


(defun jouke-get-action-source ()
  "find the document number for this action"
  (save-excursion
    (save-match-data
      (re-search-backward "\+LATEX:[\\ ]+def[\\ ]+crNumber[ ]*{\\([ 0-9]+/[ 0-9]+\\)}" nil t)
      (format "DMPE/CR-RA-%s" (match-string 1)))))

(defun jouke-make-pdf ()
  "make the pdf of this meeting"
  (interactive)
  (save-excursion
    (jouke-move-actions)
    (re-search-backward "# StartSection" nil t)
    (org-latex-export-to-pdf nil 's )))

(defun jouke-make-beamer-pdf ()
  "make the pdf of this meeting"
  (interactive)
  (save-excursion
    (jouke-move-actions)
    (re-search-backward "# StartSection" nil t)
    (org-beamer-export-to-pdf nil 's )))

(defun jouke-make-latex ()
  "make the pdf of this meeting"
  (interactive)
  (save-excursion
    (jouke-move-actions)
    (re-search-backward "# StartSection" nil t)
    (org-latex-export-to-latex nil 's )))

(add-to-list 'org-latex-classes
          '("myOrg"
             "\\documentclass{myOrg}
             [NO-DEFAULT-PACKAGES]
             [PACKAGES]
             [EXTRA]"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
	  )
(add-to-list 'org-latex-classes
          '("article"
             "\\documentclass{article}
             [NO-DEFAULT-PACKAGES]
             [PACKAGES]
             [EXTRA]"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
	  )

(setq org-todo-keywords
           '((sequence "TODO" "|" "DONE")
             (sequence "ACTION" "|" "CLOSED")))


;; === Latex export ===
(setq org-latex-default-packages-alist
   (quote
    (("AUTO" "inputenc" t ("pdflatex"))
     ("T1" "fontenc" t ("pdflatex"))
     ("" "graphicx" t nil)
     ("" "grffile" t nil)
     ("" "longtable" nil nil)
     ("" "wrapfig" nil nil)
     ("" "rotating" nil nil)
     ("normalem" "ulem" t nil)
     ("" "amsmath" t nil)
     ("" "textcomp" t nil)
     ("" "amssymb" t nil)
     ("" "capt-of" nil nil)
     ("" "hyperref" t nil))))
;; === Agenda layout and stuff ===
(setq org-columns-default-format "%70ITEM(Task)%16TIMESTAMP_IA(When)")
(setq org-agenda-custom-commands
      '(
	(" " "Export Schedule" (
				(agenda ""
					(
					 (org-agenda-overriding-header "Today's Schedule:")
					 (org-agenda-tag-filter-preset (quote ("-noagenda")))
					 (org-agenda-ndays 1)
					 (org-agenda-start-on-weekday nil)
					 (org-agenda-start-day "+0d")
					 )
					)
				(tags-todo "-DEADLINE-SCHEDULED=\"nil\""
					   (
					    (org-agenda-overriding-header "Task without date:")
					    (org-agenda-tag-filter-preset (quote ("-noagenda")))
					    )
					   )
				(agenda ""
					(
					 (org-agenda-overriding-header "Next 30 days:")
					 (org-agenda-tag-filter-preset (quote ("-noagenda")))
					 (org-agenda-span 30)
					 (org-agenda-start-day "+1d")
					 )
					)
				)
	 )
      )
)
;; === Pointage (ça me gonfle !!) ===
;; (defun jouke-pointe (h)
;;   "do pointage for this week"
;;   (interactive)
;;   (save-excursion)
;;   (

;; === Slides ===
(setq org-export-allow-bind-keywords t)

;; === Gantt etc ===
;;(load "~/.emacs.d/org-gantt/org-gantt.el")

;; === Org panes ===
;; (load "~/.emacs.d/org-panes/org-panes.el")
