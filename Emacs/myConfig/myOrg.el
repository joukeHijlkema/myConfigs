(use-package ox)
(use-package find-lisp)
(use-package org-bullets
 :hook
  (org-mode . (lambda () (org-bullets-mode 1)))
  )
(use-package org
  :mode ("\\.org\\'" . org-mode)
  :ensure t
  :after   (ox find-lisp)
  :init
  (message "=== my init org-mode")

  ;;|--------------------------------------------------------------
  ;;|Description : Add an action
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 25-41-2019 11:41:59
  ;;|--------------------------------------------------------------
  (defun myOrg-add-action ()
    "Add an action"
    (interactive)
    (save-excursion
      (re-search-backward "# StartSection" nil t)
      (search-forward "-actions-")
      (beginning-of-line)
      (let* ((Desc (read-string "Description:"))
             (Resp (read-string "Resonsible:"))
             (Due (read-string "Due:"))
             (Id (format "%s" (+ 1 (jouke-count-actions))))
             (Ref (jouke-get-action-source))
             )
        (org-insert-heading-after-current)
        (org-demote-subtree)
        (org-insert-property-drawer)
        (org-edit-headline (format "ACTION %s: %s" Id  Desc))
        (org-entry-put nil "RESPONSABLE" Resp)
        (org-entry-put nil "DESCRIPTION" Desc)
        (org-entry-put nil "DUE" Due)
        (org-entry-put nil "REF" Ref)
        (org-entry-put nil "ID" Id)
        )))
  ;;|--------------------------------------------------------------
  ;;|Description : Return the head of the action table as a function of language
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 25-02-2019 11:02:37
  ;;|--------------------------------------------------------------
  (defun myOrg-actionTable-head ()
    "Return the head of the action table as a function of language"
    (message "point = %s" (point))
    (let* ((lang (upcase (org-entry-get (point) "LANGUAGE" t)))
           (out (cond ((equal lang "ENGLISH") "|Reference|#|Description|responsible|due date|state|Note|\n")
                      ((equal lang "FRANCAIS") "|Référence|#|Description|responsable|date lim.|état|Note|\n")
                      )))
      (message "Language = %s" lang)
      (message "%s" out)
      out
    ))
  ;;|--------------------------------------------------------------
  ;;|Description : get the open actions and insert 
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 10-12-2019 12:12:25
  ;;|--------------------------------------------------------------
  (defun jouke-actions-to-table ()
    "get the open actions and insert "
    (interactive)
    (save-excursion
      (re-search-backward "# StartSection" nil t)
      (let* ((head (myOrg-actionTable-head))
             (body (org-element-map (org-element-parse-buffer 'headline) 'headline
                     (lambda (item)
                       (let ((key  (org-element-property :todo-keyword item)))
                         (cond ((equal key "ACTION") (jouke-action-row item))
                               ((equal key "CLOSED") (jouke-closed-row item)))))
                     )))
        (search-forward "* Actions")
        (org-mark-subtree)
        (move-beginning-of-line 2)
        (delete-region (point) (region-end))
        (insert "#+ATTR_LATEX: :environment longtable :align |c|c|p{0.35\\textwidth}|c|c|c|p{0.1\\textwidth}|\n")
        (insert "|-+-+-+-+-+-+-|\n")
        (insert head)
        (insert "|-+-+-+-+-+-+-|\n")
        (insert "|||<50>||||<20>|\n")
        (insert (string-join body ""))
        (insert "|-+-+-+-+-+-+-|\n")
        )
      )
    )
  ;;|--------------------------------------------------------------
  ;;|Description : get action line
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 10-13-2019 17:13:41
  ;;|--------------------------------------------------------------
  (defun jouke-action-row (item)
    "get action line"
    (message "action")
    (format "|%s|%s|%s|%s|%s|O|-|\n"
              (org-element-property :REF item)
              (org-element-property :ID item)
              (org-element-property :DESCRIPTION item)
              (org-element-property :RESPONSABLE item)
              (org-element-property :DUE item)
              )
    )
  ;;|--------------------------------------------------------------
  ;;|Description : closed row
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 10-16-2019 17:16:34
  ;;|--------------------------------------------------------------
  (defun jouke-closed-row (item)
    "closed row"
    (message "closed")
    (let* ((ns (org-element-property :contents-begin item))
           (ne (org-element-property :contents-end item))
           (txt (buffer-substring ns ne))
           (dummy (string-match "\\(- CLOSING NOTE .*\n\\)\\(.*\\)" txt))
           (Note (match-string 2 txt))
           )
      (message "text: %s\n" txt)
      (format "|%s|%s|%s|%s|%s|C|%s|\n"
              (org-element-property :REF item)
              (org-element-property :ID item)
              (org-element-property :DESCRIPTION item)
              (org-element-property :RESPONSABLE item)
              (org-element-property :DUE item)
              Note
              )
      )
    )
  ;;|--------------------------------------------------------------
  ;;|Description : count the existing actions
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 10-28-2019 19:28:32
  ;;|--------------------------------------------------------------
  (defun jouke-count-actions ()
    "count the existing actions"
    (interactive)
    (let ((out (org-element-map (org-element-parse-buffer) 'headline
                 (lambda (item)
                   (let* ((key  (org-element-property :todo-keyword item)))
                     (cond ((equal key "ACTION") t)
                           ((equal key "CLOSED") t)
                           )
                     )
                   )
                 )))
      (length out)
      )
    )
  
  (defun jouke-get-action-source ()
    "find the document number for this action"
    (save-excursion
      (save-match-data
  	(re-search-backward "\+LATEX:[\\ ]+def[\\ ]+crNumber[ ]*{\\([ 0-9]+/[ 0-9]+\\)}" nil t)
  	(format "DMPE/CR-RA-%s" (match-string 1)))))
  
  (defun jouke-make-pdf (doAction)
    "make the pdf of this meeting"
    (interactive)
    (save-excursion
      (jouke-sub-aer)
      (re-search-backward "# StartSection" nil t)
      (when doAction
        (progn (jouke-actions-to-table)
               (re-search-backward "# StartSection" nil t)))
      (let* ((outFile (org-latex-export-to-pdf nil 's )))
        (org-open-file outFile)
        outFile
        )))
  ;;|--------------------------------------------------------------
  ;;|Description : pick print action
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 16-40-2019 14:40:14
  ;;|--------------------------------------------------------------
  (defun myOrg-print-action ()
    "pick print action"
    (interactive)
    (let* ((choices '("PAD" "DA" "PDF" "PLANNING"))
           (act (ido-completing-read "Action:" choices )))
      (cond ((equal act "PAD")
             (myOrg-PAD))
            ((equal act "DA")
             (myOrg-DA))
            ((equal act "PDF")
             (jouke-make-pdf nil))
            ((equal act "PLANNING")
             (org-taskjuggler-export-and-process))
            )
      )
    )
  ;;|--------------------------------------------------------------
  ;;|Description : get the AER of this document
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 04-51-2019 15:51:12
  ;;|--------------------------------------------------------------
  (defun jouke-get-aer ()
    "get the AER of this document"
    (interactive)
    (if (org-entry-get nil "AER" t) (org-entry-get nil "AER" t) "00000")
    )
  (defun jouke-sub-aer ()
    "substitute -AER- with the content of variable AER"
    (interactive)
    (let ((opt (org-entry-get nil "EXPORT_LATEX_CLASS_OPTIONS" t))
  	  (aer (jouke-get-aer))
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

  ;;|--------------------------------------------------------------
  ;;|Description : pick a file for capture and file the stuff
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 07-33-2019 17:33:17
  ;;|--------------------------------------------------------------
  (defun myOrg-captureFile ()
    "pick a file for capture and file the stuff"
    (interactive "P")
    (setq myOrg-capture-type "file")
    (let* ((file (read-file-name "Enter file name: ")))
      (find-file file)
      (goto-char (point-max))
      )
    )
  ;;|--------------------------------------------------------------
  ;;|Description : capture an event
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 08-21-2019 12:21:22
  ;;|--------------------------------------------------------------
  (defun myOrg-captureEvent ()
    "capture an event"
    (interactive "P")
    (setq myOrg-capture-type "event")
    (let* ((choices '("Absences" "Deplacements" "Essais" "Reunions" "Divers"))
           (cal (ido-completing-read "Calendar:" choices )))
      (cond ((equal cal "Absences")
             (find-file "~/Documents/Org/Calendar/Absences.org"))
            ((equal cal "Deplacements")
             (find-file "~/Documents/Org/Calendar/Deplacements.org"))
            ((equal cal "Essais")
             (find-file "~/Documents/Org/Calendar/Essais.org"))
            ((equal cal "Reunions")
             (find-file "~/Documents/Org/Calendar/Reunions.org"))
            ((equal cal "Divers")
             (find-file "~/Documents/Org/Calendar/Divers.org"))
            )
      (goto-char (point-max))
      )
    )

  ;;|--------------------------------------------------------------
  ;;|Description : send an email to dominique for a PAD
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 16-25-2019 11:25:27
  ;;|--------------------------------------------------------------
  (defun myOrg-PAD ()
    "send an email to dominique for a PAD"
    (interactive)
    (let* ((nPad (string-trim (org-table-get-field 5)))
           (AER (org-entry-get nil "AER" t)))
      (mu4e-compose-new)
      (message-goto-to)
      (insert "dominique.clausel@onera.fr")
      (message-goto-subject)
      (insert (format "PAD #%s" nPad))
      (message-goto-body)
      (insert "Bonjour Dominque,\n")
      (insert (format "J'ai viens de valider le PAD N° %s pour l'étude %s.\n" nPad AER))
      (insert "Bonne journée,\n\nJouke")
      )
    )
  ;;|--------------------------------------------------------------
  ;;|Description : make a DA
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 16-23-2019 12:23:28
  ;;|--------------------------------------------------------------
  (defun myOrg-DA ()
    (interactive)
    (let* ((pdfFile (jouke-make-pdf nil))
           (AER (org-entry-get nil "AER" t))
           (root (org-entry-get nil "devisRoot" t))
           (title (replace-regexp-in-string " " "_" (org-get-heading t t))))

      (copy-file pdfFile (format "%s/DA_%s.pdf" root title) t)
      (split-window-below)
      (mu4e-compose-new)
      (message-goto-to)
      (insert "dominique.clausel@onera.fr")
      (message-goto-subject)
      (insert (format "DA pour étude %s" AER))
      (message-goto-body)
      (insert "Bonjour Dominque,\n")
      (insert (format "Voila un DA pour l'étude %s en PJ\n" AER))
      (insert "Bonne journée,\n\nJouke")
      (goto-char (point-max))
      (mml-attach-file (format "%s/DA_%s.pdf" root title))
      (mml-attach-file (format "%s/Devis_%s.pdf" root title))
      )
    )

  ;;|--------------------------------------------------------------
  ;;|Description : open inkscape, create a file and insert a link
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 20-43-2019 12:43:16
  ;;|--------------------------------------------------------------
  (defcustom org+-link-target-re "^file:\\(.*\\)$"
    "Regexp identifying file link targets."
    :group 'org-link
    :type 'regexp)
  
  (defun myOrg-sketch  ()
    "open inkscape, create a file and insert a link. Or edit the file in the existing link"
    (interactive)
    (if (looking-back org-bracket-link-regexp (line-beginning-position))
        (progn
          (setq url (match-string 1))
          (setq fname (and (string-match org+-link-target-re url) (match-string 1 url))))
      (progn
        (setq fname (read-string))
        (insert (format "#+ATTR_ORG: :width 500px\n[[file:%s]]" fname))
        )
      )
    (let ((buf (get-buffer-create "*org process*")))
      (ignore-errors (copy-file "/home/hylkema/myConfigs/Emacs/myConfig/template.svg" fname 1))
      (start-process "*org process*" buf "inkscape" fname)
      )
    )

  ;;|--------------------------------------------------------------
  ;;|Description : Date and time format for export
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 27-47-2019 12:47:41
  ;;|--------------------------------------------------------------
  (defun myOrg_export_date (trans back _comm)
    "Date and time format for export"
    (message "=== Jouke export date %s:%s:%s" trans back _comm)
    (pcase back
      ((or `jekyll `html)
       (replace-regexp-in-string "&[lg]t;" "" trans))
      (`latex
       (replace-regexp-in-string "[<>]" "" trans)))
    )
    
  ;;|--------------------------------------------------------------
  ;;|Description : count all CRs in the given year
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 04-58-2019 13:58:56
  ;;|--------------------------------------------------------------
  (defun jouke-count-cr (&optional year)
    "count all CRs in the given year"
    (if (not year) (setq year (format-time-string "%Y")))
    (let ((candidates (org-element-map (org-element-parse-buffer) 'headline
                        (lambda (item)
                          (if (and (equal (org-element-property :TYPE item) "CR")
                                   (equal (org-element-property :YEAR item) year))
                              year))
                        )))
      (message "%s CRs in %s" (length candidates) year)
      (+ 1 (length candidates))
      ))

  ;;|--------------------------------------------------------------
  ;;|Description : Get all the CRs in this document as sprintable string
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 04-28-2019 14:28:13
  ;;|--------------------------------------------------------------
  (defun jouke-get-cr ()
    "Get all the CRs in this document"
    (interactive)
    (let* ((candidates ())
           (aer (jouke-get-aer))
           (res (org-element-map (org-element-parse-buffer) 'headline
                  (lambda (item)
                    (if (equal (org-element-property :TYPE item) "CR")
                        (let* ((year (org-element-property :YEAR item))
                               (count (+ 1 (if (assoc year candidates) (cdr (assoc year candidates)) 0))))
                          (map-put candidates year count)
                          (format "- DMPE/CR-CA-%s/%s-%s" count year aer)
                          )
                      )
                    )
                  )
                )
           )
      (mapconcat 'identity res "\n")
      )
    )
  ;;|--------------------------------------------------------------
  ;;|Description : do something with the item under the cursor
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 24-10-2020 12:10:45
  ;;|--------------------------------------------------------------
  (defun myOrg-jump ()
    "do something with the thing under the cursor"
    (interactive)
    (let* ((str (thing-at-point 'line t)))
      (cond
       ((string-match "\\(annot-\\)\\([[:digit:]]+\\)" str)
        (let* ((p (match-string 2 str)))
          (windmove-right)
          (pdf-view-goto-page (string-to-number p))))
       (t (error "do not know what to do with %s " str))
       )
      )
    )
  ;;|--------------------------------------------------------------
  ;;|Description : get a screencap from the tablet
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 26-48-2020 11:48:50
  ;;|--------------------------------------------------------------
  (defun myOrg-get-from-tablet (caption)
    "get a screencap from the tablet"
    (interactive "sCaption : ")
    (let* ((target (format "screencap_%s.png" (substring (shell-command-to-string "uuidgen") 0 -1)))
           (targetDir (format "%s/IMAGES" default-directory)))
      (shell-command (format "mkdir -p %s" targetDir))
      (shell-command (format "adb shell screencap -p > %s/%s" targetDir target))
      (insert (format "[[file:IMAGES/%s][%s]]" target caption))
      )
    )
  ;;|--------------------------------------------------------------
  ;;|Description : get paste from tablet
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 06-19-2020 10:19:21
  ;;|--------------------------------------------------------------
  (defun myOrg-paste-from-tablet ()
    "get paste from tablet"
    (interactive)
    (let* ((choices '("Clipboard" "Screenshot" ))
           (act (ido-completing-read "Action:" choices )))
      (cond ((equal act "Clipboard")
             (let* ((target "/tmp/paste.txt"))
               (shell-command (format "adb shell am broadcast -a clipper.get > %s" target))
               (insert-file target)
               ))
            ((equal act "Screenshot")
             (let* ((caption (read-string "Caption: "))
                    (target (format "screencap_%s.png" (substring (shell-command-to-string "uuidgen") 0 -1)))
                    (targetDir (format "%s/IMAGES" default-directory)))
               (shell-command (format "mkdir -p %s" targetDir))
               (shell-command (format "adb shell screencap -p > %s/%s" targetDir target))
               (insert (format "[[file:IMAGES/%s][%s]]" target caption))
               ))
            )
      )
    )
  ;;|--------------------------------------------------------------
  ;;|Description : get current org level number of symbols
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 18-35-2020 17:35:50
  ;;|--------------------------------------------------------------
  (defun myOrg-get-current-level (symbol)
    "get current org level or empty"
    (make-string (- (if (org-current-level) (org-current-level) 1) 1) symbol)
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
  	  ("\\.pdf\\'" . default)
  	  ("\\.xls\\'" . default)
  	  )))
  (org-log-done (quote note))
  (org-support-shift-select t)
  (org-display-inline-images t)
  (org-agenda-files '("~/Documents/Org" "~/Documents/GTD" "~/Documents/Org/Calendar"))
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
  					   (org-agenda-overriding-header "Today:")
  					   (org-agenda-tag-filter-preset (quote ("-noagenda")))
  					   (org-agenda-ndays 1)
  					   (org-agenda-start-on-weekday nil)
  					   (org-agenda-start-day "+0d")
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
   '(("t" "Todo[inbox]" entry
      (file+headline "~/Documents/GTD/inbox.org" "Tasks") "* TODO %? %^g\n  %i\n  %a")
     ("w" "Waiting for" entry
      (file+headline "~/Documents/GTD/waiting" "Tasks") "* WORKING Waiting:%? \nEntered on %U\n link:%a")
     ("T" "Tickler"     entry
      (file+headline "~/Documents/GTD/tickler.org" "Tasks") "* %i%? \n %U\n %a")
     ("p" "Pick a file (reload to see effect)" entry (function myOrg-captureFile))
     ("e" "Event" entry (function myOrg-captureEvent) "* JH-%? \n%a")
     ))
  (org-refile-targets '(("~/Documents/GTD/gtd.org" :maxlevel . 3)
                        ("~/Documents/GTD/someday.org" :level . 1)
                        ("~/Documents/GTD/tickler.org" :maxlevel . 2)
                        ("~/Documents/GTD/waiting.org" :level . 1)
                        ))
  (org-todo-keywords-for-agenda (list "TODO" "WORKING" "|" "DONE" "ACTION" "|" "CLOSED"))
  (org-todo-keywords
   '((sequence "TODO(t)" "WORKING(w)" "|" "DONE(d)")
     (sequence "ACTION" "|" "CLOSED")))
  (org-format-latex-options (plist-put org-format-latex-options :scale 1.3))
  (org-link-frame-setup
   (quote
    ((vm . vm-visit-folder-other-frame)
     (vm-imap . vm-visit-imap-folder-other-frame)
     (gnus . org-gnus-no-new-news)
     (file . myOpenLink)
     (wl . wl-other-frame))))
  
  ;; === config ===

  :config
  (message "=== myOrg config start")
  (global-linum-mode 0)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (gnuplot . t)
     (emacs-lisp . t)
     (shell . t)
     (python . t)
     (latex .t)
     (dot . t)
     ))
  (org-clock-persistence-insinuate)
  (flyspell-mode t)
  (turn-on-flyspell)
  (visual-line-mode t)
  (global-visual-line-mode)
  (org-bullets-mode 1)
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
  (add-to-list 'org-export-filter-timestamp-functions  'myOrg_export_date)

  (org-save-all-org-buffers)

  (add-hook 'org-capture-after-finalize-hook 'myCalDavSave)
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

  ;; === Hooks ===

  :hook
  (org-agenda-mode . (lambda ()
        	       (message "== org mode start hook")
        	       (visual-line-mode -1)
        	       (toggle-truncate-lines 1)
        	       ))
  
  ;; === Bindings ===

  :bind (("<s-insert>" . org-capture)
         (:map org-mode-map
              ("s-i"	. org-clock-in)
              ("s-o"	. org-clock-out)
              ("<s-f8>"	. org-agenda)
              ("<s-f12>" .  myOrg-print-action)
              ("<s-prior>" . org-refile)
              ("<s-next>" . org-archive-subtree-default)
              ("<s-end>" . org-caldav-sync)
              ("s-!" . myOrg-add-action)
              ("<s-return>" . myOrg-jump)
              ("s-p" . myOrg-paste-from-tablet)
              ))
         
              
  )
