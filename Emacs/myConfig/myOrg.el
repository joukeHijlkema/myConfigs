(use-package ox)
(use-package find-lisp)
(use-package org
  :mode ("\\.org\\'" . org-mode)
  :ensure t
  :after   (ox find-lisp)
  :init
  (message "=== my init org-mode")
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

  (defun jouke-getNote (item)
    "extracte the note bit from an closed action"
    (let* ((items (split-string item "\n")))
      (string-trim (string-join (cdr items) ". "))
    ))
  
  (defun jouke-openAction (elt mode)
    "create a row for an open action"
    (if (equal (org-element-property :todo-keyword elt) "ACTION") 
        (let* ((items (split-string (org-element-property :raw-value elt) "#")))
          (pcase mode
            ("list"
             (list (nth 4 items) 
        	   (nth 0 items)
        	   (nth 1 items)
        	   (nth 1 (split-string (nth 2 items)))
        	   (nth 3 items)
        	   "O" "-"
        	   ))
            ("str"
             (concat "|" (nth 4 items)
        	     "|" (nth 0 items)
        	     "|" (nth 1 items)
        	     "|" (nth 1 (split-string (nth 2 items)))
        	     "|" (nth 3 items)
        	     "|O|-") 
             )))))
  
  (defun jouke-closedAction (elt mode)
    "create a row for a closed action"
    (if (equal (org-element-property :todo-keyword elt) "CLOSED")
        (let* ((cn  (org-element-map elt 'item (lambda (p) p) nil t))
               (cs  (org-element-property :contents-begin cn))
               (ce  (org-element-property :contents-end cn))
               (ct  (if cs (buffer-substring cs ce) "-"))
               (items (split-string (org-element-property :raw-value elt) "#"))
               )
          (pcase mode
            ("list"
             (list (nth 4 items) 
        	   (nth 0 items)
        	   (nth 1 items)
        	   (nth 1 (split-string (nth 2 items)))
        	   (nth 3 items)
        	   "C" 
        	   (jouke-getNote ct)))
            ("str"
             (concat "|" (nth 4 items)
        	     "|" (nth 0 items)
        	     "|" (nth 1 items)
        	     "|" (nth 1 (split-string (nth 2 items)))
        	     "|" (nth 3 items)
        	     "|C"
        	     "|" (jouke-getNote ct)))
            ))))
  
  (defun jouke-makeActionList ()
    
    (let* ((out '(hline ("Reference" "#" "Description" "Resp:" "Due date" "State" "Note")))
           (ast (org-element-parse-buffer)))
      (org-element-map ast 'headline
        (lambda (hl) 
          (cl-case (org-element-property :todo-type hl)
            ('todo (push (jouke-openAction hl "list") out))
            ('done (push (jouke-closedAction hl "list") out))
            (otherwise nil)
            )
          )
        )
      (reverse out)
      ))
  
  (defun jouke-makeActionList2 ()
    (let* ((ast (org-element-parse-buffer)))
      (print "|Reference|#|Description|Resp|Due date|State|Note|")
      (print "|         | |<50>       |    |        |     |<20>|")
      (print "|---------|-|-----------|----|--------|-----|----|")
      (org-element-map ast 'headline
        (lambda (hl) 
          (cl-case (org-element-property :todo-type hl)
            ('todo (print (jouke-openAction hl "str")))
            ;;('done (print (jouke-closedAction hl) out))
            (otherwise nil)
            )
          )
        )
      ))
  
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
        	      (jouke-get-note-from-line l))
        	      ;; "="
        	      ))))
  (defun jouke-get-note-from-line (l)
    "get the closing note from a line if it is there"
    (save-match-data
      (string-match jouke-re-action-complete l)
      (message (format "line : %s" l))
      (message (format "match 1 : %s" (match-string 1 l)))
      (message (format "match 2 : %s" (match-string 2 l)))
      (message (format "match 3 : %s" (match-string 3 l)))
      (message (format "match 4 : %s" (match-string 4 l)))
      (message (format "match 5 : %s" (match-string 5 l)))
      (message (format "match 6 : %s" (match-string 6 l)))
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
  (defun endless/filter-timestamp (trans back _comm)
    "Remove <> around time-stamps."
    (pcase back
      ((or `jekyll `html)
       (replace-regexp-in-string "&[lg]t;" "" trans))
      (`latex
       (replace-regexp-in-string "[<>]" "" trans))))
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
      (while (< (point) (- (org-table-end) 1))
  	(move-end-of-line 1)
  	(setq p2 (point))
  	(setq p1 (- p2 dp))
  	(setq p0 (- p2 dpl))
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

  ;; === Custom ===

  :custom
  (message "=== myOrg custom start")
  (org-display-inline-images t)
  (org-agenda-file-regexp "^[^#]*\\.org$")
  (org-agenda-skip-scheduled-if-done t)
  (org-file-apps
  	(quote
  	 ((auto-mode . emacs)
  	  ("\\.mm\\'" . default)
  	  ("\\.x?html?\\'" . default)
  	  ("\\.pdf\\'" . "/usr/bin/evince %s")
  	  ("\\.xls\\'" . default)
  	  )))
  (org-log-done (quote note))
  (org-support-shift-select t)
  (org-display-inline-images t)
  (org-agenda-files '("~/Documents/Org" "~/org"))
  (org-clock-persist 'history)
  (org-startup-indented t)
  (org-confirm-babel-evaluate nil)
  (jouke-re-action-simple "\\*\\*\\* \\(ACTION\\|CLOSED\\)")
  (jouke-re-action-medium "\\*\\*\\* \\(CLOSED\\|ACTION\\).\\([0-9]*\\) *# *\\([^#]*\\) *# *resp *\\([^#]*\\) *# *\\([^#]*\\) *# *\\([^#]*\\)")
  (jouke-re-action-complete "\\*\\*\\* \\(ACTION\\|CLOSED\\)\\([^:]+:.*\\)\\(\\([\n ]+CLOSED:.*\\)?\\([\n -]+CLOSING NOTE.*\\))?\\([\n ]+.*\\)?\\)?")
  (org-latex-default-packages-alist
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

  (org-latex-active-timestamp-format "\\texttt{%s}")
  (org-latex-inactive-timestamp-format "\\texttt{%s}")
  (org-display-custom-times t)
  (org-time-stamp-custom-formats
  	'("<%d/%m/%Y %a>" . "<%d/%m/%y %a %H:%M>"))
  (org-columns-default-format "%70ITEM(Task)%16TIMESTAMP_IA(When)")
  (org-agenda-custom-commands
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
  (org-export-allow-bind-keywords t)
  (org-default-notes-file (concat org-directory "~/Documents/Org/notes.org"))
  (org-capture-templates
  	'(("t" "Todo" entry (file+headline "~/Documents/Org/gtd.org" "Tasks")
           "* TODO %? %^g\n  %i\n  %a")
  	  ("j" "Journal" entry (file+olp+datetree "~/Documents/Org/journal.org")
           "* %? %^g\nEntered on %U\n  %i\n  %a")))
  (org-todo-keywords-for-agenda (list "TODO" "WORKING" "|" "DONE" "ACTION" "|" "CLOSED"))
  (org-todo-keywords
   '((sequence "TODO(t)" "WORKING(w)" "|" "DONE(d)")
     (sequence "ACTION" "|" "CLOSED")))
  (org-format-latex-options (plist-put org-format-latex-options :scale 1.3))

  ;; === config ===

  :config
  (message "=== myOrg config start")
  
  (org-agenda-files (find-lisp-find-files "~/Documents/Org" "\.org$"))
  (global-linum-mode 0)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (gnuplot . t)
     (emacs-lisp . t)
     (shell . t)
     (python . t)
     (latex .t)
     ))
  (org-clock-persistence-insinuate)
  (flyspell-mode t)
  (turn-on-flyspell)
  (visual-line-mode t)
  (global-visual-line-mode)
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
  (add-to-list 'org-export-filter-timestamp-functions
             #'endless/filter-timestamp)

  (org-save-all-org-buffers)

  ;; === Hooks ===

  :hook
  (org-agenda-mode . (lambda ()
        	       (message "== org mode start hook")
        	       (visual-line-mode -1)
        	       (toggle-truncate-lines 1)
        	       ))

  ;; === Bindings ===

  :bind
  ("s-i"	.	org-clock-in)
  ("s-o"	.	org-clock-out)
  ("s-a"	.	org-mactions-new-numbered-action)
  ("<s-f8>"	.	org-agenda)
  ("<s-f9>"	.	(lambda () (interactive) (org-latex-export-to-pdf nil 's)))
  ("<s-f10>"	.	jouke-make-beamer-pdf)
  ("<s-f11>"	.	jouke-make-latex)
  ("<s-f12>"	.	jouke-make-pdf)
  ("s-c"	.	org-capture)
  )
