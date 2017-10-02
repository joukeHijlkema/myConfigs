;; remove toolbar
(tool-bar-mode -1)

(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))

(add-to-list 'auto-mode-alist '("\\.FCMacro\\'" . python-mode))

(tabbar-mode t)
(yas-global-mode t)
(setq tramp-default-method "ssh")
(setq speedbar-initial-expansion-list-name "buffers")

(yas-global-mode t)
(autoload 'cflow-mode "cflow-mode")
(setq auto-mode-alist (append auto-mode-alist '(("\\.cflow$" . cflow-mode))))

(load "~/.emacs.d/keys.el")
(load"~/.emacs.d/Languages/Python.el")
(load"~/.emacs.d/Languages/C++.el")

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'"	.	web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'"	.	web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.xml?\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'"		.	web-mode))

;;Auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)
(setq ispell-program-name "aspell")
(setq ispell-dictionary "english") 

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(defun turn-on-outline-minor-mode ()
(outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else

(require 'tex-site)
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(setq LaTeX-eqnarray-label "eq"
LaTeX-equation-label "eq"
LaTeX-figure-label "fig"
LaTeX-table-label "tab"
LaTeX-myChapter-label "chap"
TeX-auto-save t
TeX-newline-function 'reindent-then-newline-and-indent
TeX-parse-self t
TeX-style-path
 '("style/" "auto/"
 "/usr/share/emacs21/site-lisp/auctex/style/"
 "/var/lib/auctex/emacs21/"
 "/usr/local/share/emacs/site-lisp/auctex/style/")
LaTeX-section-hook
'(LaTeX-section-heading
LaTeX-section-title
LaTeX-section-toc
LaTeX-section-section
LaTeX-section-label))

(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))

(add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-vc-set-filter-groups-by-vc-root)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic))))

;; Journal
(require 'org-journal)

;; Workgroups2
(require 'workgroups)
(workgroups-mode 1)
(wg-load "~/myConfigs/Emacs/workGroups")

;; =======================================
;; Orgmode
;; =======================================
(if (boundp 'warning-suppress-types)
    (add-to-list 'warning-suppress-types' (yasnippet backquote-change))
  (setq warning-suppress-types '((yasnippet backquote-change))))

(defun jouke-count-actions ()
  "count the ACTION items in a document "
  (interactive)
  (save-excursion
    (setq ac 0)
    (setq case-fold-search nil)
    (goto-char (point-min))
    (while (re-search-forward "\\*\\*\\* \\(ACTION\\|CLOSED\\)" (point-max) t)
      (setq ac (1+ ac)))
  (print ac)))

(defun jouke-move-actions ()
  "fill the action table"
  (interactive)
  (setq case-fold-search nil)
  (save-excursion
    ;; find the first action table insertion point and delete existing lines
    (search-forward "# ActionTable" (point-max) t)
    (forward-line 5)
    (while (re-search-forward "^|" (+ (point) 1) t)
      (kill-whole-line))
    (dolist (elt (reverse (jouke-matches-in-buffer "\\*\\*\\* \\(ACTION\\|CLOSED\\).*")))
      (jouke-print-action elt))))
  
(defun jouke-matches-in-buffer (regexp &optional buffer)
  "return a list of matches of REGEXP in BUFFER or the current buffer if not given."
  (setq case-fold-search nil)
  (let ((matches))
    (save-excursion
      (save-match-data
	(with-current-buffer (or buffer (current-buffer))
	  (save-restriction
	    (widen)
	    (goto-char 1)
	    (while (search-forward-regexp regexp nil t 1)
	      (push (match-string 0) matches)))))
      matches)))

(defun jouke-print-action (l)
  "format a table row from an action"
    (save-match-data
      (string-match "\\*\\*\\* \\(CLOSED\\|ACTION\\).\\([0-9]*\\) *# *\\([^#]*\\) *# *resp *\\([^#]*\\) *# *\\([^#]*\\)" l)
      (insert (format "|DMAE-truc-%s|%s|%s|%s|%s|\n"
		      (match-string 2 l)
		      (match-string 3 l)
		      (match-string 4 l)
		      (match-string 5 l)
		      (if (string= (match-string 1 l) "ACTION")
			  "O"
			"C")))))

(add-to-list 'org-latex-classes
          '("MOM"
             "\\documentclass{MOM}
             [NO-DEFAULT-PACKAGES]
             [PACKAGES]
             [EXTRA]"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-todo-keywords
           '((sequence "TODO" "|" "DONE")
             (sequence "ACTION" "|" "CLOSED")))
