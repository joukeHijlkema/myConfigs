(setq org-agenda-file-regexp "^[^#]*\\.org$")
(setq org-agenda-skip-scheduled-if-done t)
(setq org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "/usr/bin/evince %s")
     ("\\.xls\\'" . default)
     )))
(setq org-log-done (quote note))
(setq org-support-shift-select t)

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (gnuplot . t)
   (emacs-lisp . t)
   (shell . t)
   (python . t)
   )
 )
;; === Images ===
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

(require 'org-journal)
(setq org-agenda-files '("~/Documents/Org" "~/org"))

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(require 'subr-x)
(with-eval-after-load 'org
  (setq org-startup-indented t)
  (flyspell-mode t)
  (visual-line-mode t))

(if (boundp 'warning-suppress-types)
    (add-to-list 'warning-suppress-types' (yasnippet backquote-change))
  (setq warning-suppress-types '((yasnippet backquote-change))))

(setq org-confirm-babel-evaluate nil)

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
    (jouke-sub-aer)
    (re-search-backward "# StartSection" nil t)
    (org-open-file (org-latex-export-to-pdf nil 's ))
    ))

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

(defun jouke-sub-aer ()
  "substitute -AER- with the content of variable AER"
  (interactive)
  (let ((opt (org-entry-get nil "EXPORT_LATEX_CLASS_OPTIONS" t))
	(aer (org-entry-get nil "AER" t))
	)
    (message "aer = %s " aer)
    (message (replace-regexp-in-string "-AER-" aer opt))
    (org-entry-put nil "EXPORT_LATEX_CLASS_OPTIONS" (replace-regexp-in-string "-AER-" aer opt))
    )
  )

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

(setq org-latex-active-timestamp-format "\\texttt{%s}")
(setq org-latex-inactive-timestamp-format "\\texttt{%s}")
(require 'ox)
(add-to-list 'org-export-filter-timestamp-functions
             #'endless/filter-timestamp)
(defun endless/filter-timestamp (trans back _comm)
  "Remove <> around time-stamps."
  (pcase back
    ((or `jekyll `html)
     (replace-regexp-in-string "&[lg]t;" "" trans))
    (`latex
     (replace-regexp-in-string "[<>]" "" trans))))
(setq-default org-display-custom-times t)
;;; Before you ask: No, removing the <> here doesn't work.
(setq org-time-stamp-custom-formats
      '("<%d/%m/%Y %a>" . "<%d/%m/%y %a %H:%M>"))

;; === Agenda layout and stuff ===
(add-hook 'org-agenda-mode-hook
          (lambda ()
            (visual-line-mode -1)
            (toggle-truncate-lines 1)))
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

;; === Table highligts ===
(defun jouke-highlight ()
  (interactive)
  (save-excursion
    (assert (org-table-p) "Not in org-table.")
    (goto-char (org-table-begin))
    (setq p0 (point))
    (move-end-of-line 1)
    (setq dpl (- (point) p0))
    (setq ep1 (search-backward "+"))
    (setq ep2 (search-forward "|"))
    (setq dp (- ep2 ep1))
    ;; (message "ep1=%d ep2=%d dp=%d dpl=%d" ep1 ep2 dp dpl)
    (while (< (point) (- (org-table-end) 1))
      (move-end-of-line 1)
      (setq p2 (point))
      (setq p1 (- p2 dp))
      (setq p0 (- p2 dpl))
      ;; (message "found %s" (buffer-substring-no-properties p1 p2))
      (if (or
	   (string-equal(buffer-substring-no-properties p1 p2) "| In  |")
	   (string-equal(buffer-substring-no-properties p1 p2) "| Ok  |")
	   (string-equal(buffer-substring-no-properties p1 p2) "+-----|")
	   (string-equal(buffer-substring-no-properties p1 p2) "|     |")
	   (string-equal(buffer-substring-no-properties p1 p2) "| yes |"))
	  (jouke-clear-highlight p0 p2)
	(jouke-set-highlight p0 p2)
	)
      (next-line)
      )
    (format "Ok")
    )
  )

(defun jouke-clear-highlight (p1 p2)
  (interactive)
  (assert (org-table-p) "Not in org-table.")
  (message "clear highlight between %s %s" p1 p2)
  (dolist (ov (overlays-in p1 p2))
    (delete-overlay ov)
    )
  )
(defun jouke-set-highlight (p1 p2)
  (message "set highlight between %s %s" p1 p2)
  (org-table-add-rectangle-overlay p1 p2 'error)
  )

;; === Captures ===
(setq org-default-notes-file (concat org-directory "~/Documents/Org/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates
 '(("t" "Todo" entry (file+headline "~/Documents/Org/gtd.org" "Tasks")
        "* TODO %? %^g\n  %i\n  %a")
   ("j" "Journal" entry (file+olp+datetree "~/Documents/Org/journal.org")
        "* %? %^g\nEntered on %U\n  %i\n  %a")))

;; === Calendar ===
(require 'calfw-org)
(setq org-todo-keywords-for-agenda (list "TODO" "WORKING" "|" "DONE" "ACTION" "|" "CLOSED"))



(defun my-skip-unless-waiting ()
  "Skip trees that are not waiting"
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (re-search-forward ":waiting:" subtree-end t)
        nil          ; tag found, do not skip
      subtree-end))) ; tag not found, continue after end of subtree


(defun jouke-filter-agenda ()
  (message "filter")
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (re-search-forward ":noagenda:" subtree-end t)
	subtree-end         ; tag found, continue after end of subtree 
      nil )))               ; tag not found do not skip

(defun jouke-switch-to-cal ()
  (interactive)
  (ignore-errors (wg-switch-to-workgroup-at-index-9))
  (let ((org-agenda-skip-function 'org-agenda-skip-work))
  ;; (let ((org-agenda-tag-filter-preset '("-noagenda")))
    (message "calendar")
    (cfw:open-org-calendar)
    (cfw:change-view-week)
    )
  )

(setq org-todo-keywords
           '((sequence "TODO(t)" "WORKING(w)" "|" "DONE(d)")
             (sequence "ACTION" "|" "CLOSED")))


(add-hook 'org-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'global-visual-line-mode)
;; (add-hook 'org-mode-hook (lambda () (linum-mode -1)))

(defun nolinum ()
  (global-linum-mode 0)
)
(add-hook 'org-mode-hook 'nolinum)

