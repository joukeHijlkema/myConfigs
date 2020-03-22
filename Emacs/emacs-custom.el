(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.50")
 '(jouke-re-action-complete
   "\\*\\*\\* \\(ACTION\\|CLOSED\\)\\([^:]+:.*\\)\\(\\([
 ]+CLOSED:.*\\)?\\([
 -]+CLOSING NOTE.*\\))?\\([
 ]+.*\\)?\\)?" t)
 '(jouke-re-action-medium
   "\\*\\*\\* \\(CLOSED\\|ACTION\\).\\([0-9]*\\) *# *\\([^#]*\\) *# *resp *\\([^#]*\\) *# *\\([^#]*\\) *# *\\([^#]*\\)" t)
 '(jouke-re-action-simple "\\*\\*\\* \\(ACTION\\|CLOSED\\)" t)
 '(message "=== my custom org presentation mode ===" t)
 '(org-agenda-custom-commands
   (quote
    ((" " "Export Schedule"
      ((agenda ""
               ((org-agenda-overriding-header "Today:")
                (org-agenda-tag-filter-preset
                 (quote
                  ("-noagenda")))
                (org-agenda-ndays 1)
                (org-agenda-start-on-weekday nil)
                (org-agenda-start-day "+0d")))
       (agenda ""
               ((org-agenda-overriding-header "Next 30 days:")
                (org-agenda-tag-filter-preset
                 (quote
                  ("-noagenda")))
                (org-agenda-span 30)
                (org-agenda-start-day "+1d"))))))))
 '(org-agenda-file-regexp "^[^#]*\\.org$")
 '(org-agenda-files
   (quote
    ("~/Documents/Org" "~/Documents/GTD" "~/Documents/Org/Calendar")))
 '(org-agenda-skip-scheduled-if-done t)
 '(org-capture-templates
   (quote
    (("t" "Todo[inbox]" entry
      (file+headline "~/Documents/GTD/inbox.org" "Tasks")
      "* TODO %? %^g
  %i
  %a")
     ("w" "Waiting for" entry
      (file+headline "~/Documents/GTD/waiting" "Tasks")
      "* WORKING Waiting:%? 
Entered on %U
 link:%a")
     ("T" "Tickler" entry
      (file+headline "~/Documents/GTD/tickler.org" "Tasks")
      "* %i%? 
 %U
 %a")
     ("p" "Pick a file (reload to see effect)" entry
      (function myOrg-captureFile))
     ("e" "Event" entry
      (function myOrg-captureEvent)
      "* JH-%? 
%a"))) t)
 '(org-clock-persist (quote history))
 '(org-columns-default-format "%70ITEM(Task)%16TIMESTAMP_IA(When)")
 '(org-confirm-babel-evaluate nil)
 '(org-default-notes-file "~/org~/Documents/Org/notes.org")
 '(org-display-custom-times t)
 '(org-display-inline-images t t)
 '(org-export-allow-bind-keywords t)
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . default)
     ("\\.xls\\'" . default))))
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 1.3 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-latex-active-timestamp-format "\\texttt{%s}")
 '(org-latex-default-packages-alist
   (quote
    (("AUTO" "inputenc" t
      ("pdflatex"))
     ("T1" "fontenc" t
      ("pdflatex"))
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
 '(org-latex-inactive-timestamp-format "\\texttt{%s}")
 '(org-link-frame-setup
   (quote
    ((vm . vm-visit-folder-other-frame)
     (vm-imap . vm-visit-imap-folder-other-frame)
     (gnus . org-gnus-no-new-news)
     (file . myOpenLink)
     (wl . wl-other-frame))))
 '(org-log-done (quote note))
 '(org-refile-targets
   (quote
    (("~/Documents/GTD/gtd.org" :maxlevel . 3)
     ("~/Documents/GTD/someday.org" :level . 1)
     ("~/Documents/GTD/tickler.org" :maxlevel . 2)
     ("~/Documents/GTD/waiting.org" :level . 1))))
 '(org-startup-indented t)
 '(org-support-shift-select t)
 '(org-time-stamp-custom-formats (quote ("<%d/%m/%Y %a>" . "<%d/%m/%y %a %H:%M>")))
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "WORKING(w)" "|" "DONE(d)")
     (sequence "ACTION" "|" "CLOSED"))))
 '(org-todo-keywords-for-agenda (quote ("TODO" "WORKING" "|" "DONE" "ACTION" "|" "CLOSED")) t)
 '(python-shell-interpreter "python3")
 '(safe-local-variable-values
   (quote
    ((eval progn
           (org-babel-goto-named-src-block "startblock")
           (org-babel-execute-src-block)
           (outline-hide-sublevels 1))
     (TeX-command-extra-options . "-shell-escape -synctex=1")
     (TeX-command-extra-options . "-shell-escape")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
