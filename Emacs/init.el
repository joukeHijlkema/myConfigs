(when (string-match-p "134\.212\.[[:digit:]]+\.[[:digit:]]+"
		      (car (split-string (shell-command-to-string (format "ip:%s" "/bin/hostname -I")))))
  (setq url-proxy-services
	'(("no_proxy" . "^\\(localhost\\|10.*\\|vandales-f.onecert.fr\\)")
	  ("http" . "minos.onecert.fr:80")
	  ("https" . "minos.onecert.fr:80"))
	)
  (message "proxies : %s" url-proxy-services)
  )

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 )
      )
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
;; (setq use-package-verbose 'Debug)
(load "~/.emacs.d/myInit.el")

(put 'upcase-region 'disabled nil)

;; (setq ecb-tip-of-the-day nil)
;; (ecb-activate)

;; (minimap-mode)
(put 'downcase-region 'disabled nil)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-begin-regexp "\\(?:begin\\|if@\\|ifx\\|ifnum\\|ifONERA@\\)\\b" t)
 '(LaTeX-end-regexp "\\(?:end\\|else\\|fi\\)\\b" t)
 '(LaTeX-eqnarray-label "eq" t)
 '(LaTeX-equation-label "eq" t)
 '(LaTeX-figure-label "fig" t)
 '(LaTeX-indent-level 1 t)
 '(LaTeX-item-indent 1 t)
 '(LaTeX-myChapter-label "chap" t)
 '(LaTeX-section-hook
   (quote
    (LaTeX-section-heading LaTeX-section-title LaTeX-section-toc LaTeX-section-section LaTeX-section-label)) t)
 '(LaTeX-table-label "tab" t)
 '(TeX-PDF-mode t t)
 '(TeX-auto-save t t)
 '(TeX-newline-function (quote reindent-then-newline-and-indent) t)
 '(TeX-parse-self t t)
 '(TeX-save-query nil t)
 '(TeX-style-path
   (quote
    ("style/" "auto/" "/usr/share/emacs21/site-lisp/auctex/style/" "/var/lib/auctex/emacs21/" "/usr/local/share/emacs/site-lisp/auctex/style/")) t)
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(custom-safe-themes
   (quote
    ("d14d421ff49120d2c2e0188bcef76008407b3ceff2cfb1d4bdf3684cf3190172" "5e515425f8a5ce00097d707742eb5eee09b27cebc693b8998c734305cbdce1f5" "a2afb83e8da1d92f83543967fb75a490674a755440d0ce405cf9d9ae008d0018" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "980f0adf3421c25edf7b789a046d542e3b45d001735c87057bccb7a411712d09" default)))
 '(default 70 t)
 '(ecb-options-version "2.50")
 '(font-latex-fontify-script nil t)
 '(font-latex-fontify-sectioning 1.1 t)
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f"))))
 '(ispell-dictionary "fr")
 '(jouke-re-action-complete
   "\\*\\*\\* \\(ACTION\\|CLOSED\\)\\([^:]+:.*\\)\\(\\([
 ]+CLOSED:.*\\)?\\([
 -]+CLOSING NOTE.*\\))?\\([
 ]+.*\\)?\\)?" t)
 '(jouke-re-action-medium
   "\\*\\*\\* \\(CLOSED\\|ACTION\\).\\([0-9]*\\) *# *\\([^#]*\\) *# *resp *\\([^#]*\\) *# *\\([^#]*\\) *# *\\([^#]*\\)" t)
 '(jouke-re-action-simple "\\*\\*\\* \\(ACTION\\|CLOSED\\)" t)
 '(message "=== myOrg custom start" t)
 '(openwith-mode nil)
 '(org-agenda-custom-commands
   (quote
    ((" " "Export Schedule"
      ((agenda ""
               ((org-agenda-overriding-header "Today's Schedule:")
                (org-agenda-tag-filter-preset
                 (quote
                  ("-noagenda")))
                (org-agenda-ndays 1)
                (org-agenda-start-on-weekday nil)
                (org-agenda-start-day "+0d")))
       (tags-todo "-DEADLINE-SCHEDULED=\"nil\""
                  ((org-agenda-overriding-header "Task without date:")
                   (org-agenda-tag-filter-preset
                    (quote
                     ("-noagenda")))))
       (agenda ""
               ((org-agenda-overriding-header "Next 30 days:")
                (org-agenda-tag-filter-preset
                 (quote
                  ("-noagenda")))
                (org-agenda-span 30)
                (org-agenda-start-day "+1d"))))))))
 '(org-agenda-file-regexp "^[^#]*\\.org$")
 '(org-agenda-files (quote ("~/Documents/Org" "~/org")))
 '(org-agenda-skip-scheduled-if-done t)
 '(org-capture-templates
   (quote
    (("t" "Todo" entry
      (file+headline "~/Documents/Org/gtd.org" "Tasks")
      "* TODO %? %^g
  %i
  %a")
     ("j" "Journal" entry
      (file+olp+datetree "~/Documents/Org/journal.org")
      "* %? %^g
Entered on %U
  %i
  %a"))))
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
     ("\\.pdf\\'" . "/usr/bin/evince %s")
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
 '(org-log-done (quote note))
 '(org-startup-indented t)
 '(org-support-shift-select t)
 '(org-time-stamp-custom-formats (quote ("<%d/%m/%Y %a>" . "<%d/%m/%y %a %H:%M>")))
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "WORKING(w)" "|" "DONE(d)")
     (sequence "ACTION" "|" "CLOSED"))))
 '(org-todo-keywords-for-agenda (quote ("TODO" "WORKING" "|" "DONE" "ACTION" "|" "CLOSED")) t)
 '(outline-minor-mode 1 t)
 '(package-selected-packages
   (quote
    (color-identifiers-mode smartparens spacemacs-theme yasnippet-snippets workgroups2 web-mode use-package uncrustify-mode tabbar sunrise-x-buttons sr-speedbar org-plus-contrib org-kanban org-journal openwith mu4e-alert mc-extras magithub latex-preview-pane langtool lab-themes evil-mu4e elpy ecb doneburn-theme counsel calfw-org calfw auctex adaptive-wrap ac-math)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e")))
 '(python-shell-interpreter "python3")
 '(reftex-plug-into-AUCTeX t t)
 '(reftex-toc-split-windows-fraction 0.25 t)
 '(reftex-toc-split-windows-horizontally t t)
 '(safe-local-variable-values (quote ((TeX-command-extra-options . "-shell-escape"))))
 '(turn-on-outline-minor-mode t t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
