(use-package latex
  :ensure
  auctex
  :mode
  ("\\.tex\\'" . latex-mode)
  :init
  (progn
   (defun turn-on-outline-minor-mode ()
     (outline-minor-mode 1))
   (unless (boundp 'org-latex-classes)
     (setq org-latex-classes nil))
   )
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (prettify-symbols-mode)
              (LaTeX-math-mode)
              (turn-on-reftex)
              (reftex-isearch-minor-mode)
              (turn-off-auto-fill)
	      (visual-line-mode)
	      (flyspell-mode)
	      ))
  :config
  (progn 
   (setq ispell-program-name "aspell")
   (setq ispell-dictionary "fr")
   (setq-default fill-column 120)
   (setq font-latex-fontify-script nil)
   (setq font-latex-fontify-sectioning 'color)
   (setq TeX-parse-self t)
   (setq TeX-save-query nil)
   (setq TeX-PDF-mode t)
   (setq LaTeX-eqnarray-label "eq"
	 LaTeX-equation-label "eq"
	 LaTeX-figure-label "fig"
	 LaTeX-table-label "tab"
	 LaTeX-myChapter-label "chap"
	 TeX-auto-save t
	 TeX-newline-function 'reindent-then-newline-and-indent
	 TeX-parse-self t
	 TeX-style-path '("style/" "auto/"
			  "/usr/share/emacs21/site-lisp/auctex/style/"
			  "/var/lib/auctex/emacs21/"
			  "/usr/local/share/emacs/site-lisp/auctex/style/")
	 LaTeX-section-hook '(LaTeX-section-heading
			      LaTeX-section-title
			      LaTeX-section-toc
			      LaTeX-section-section
			      LaTeX-section-label)
	 )
   (setq reftex-plug-into-AUCTeX t)
   (turn-on-outline-minor-mode)
   (setq LaTeX-begin-regexp "\\(?:begin\\|if@\\|ifx\\|ifnum\\|ifONERA@\\)\\b")
   (setq LaTeX-end-regexp "\\(?:end\\|else\\|fi\\)\\b")
   (defun LaTeX-indent-level-count ()
     "Count indentation change caused by all \\left, \\right, \\begin, and
      \\end commands in the current line."
     (save-excursion
       (save-restriction
   	 (let ((count 0))
           (narrow-to-region (point)
                             (save-excursion
                               (re-search-forward
   				(concat "[^" TeX-esc "]"
   					"\\(" LaTeX-indent-comment-start-regexp
   					"\\)\\|\n\\|\\'"))
                               (backward-char)
                               (point)))
           (while (search-forward TeX-esc nil t)
             (cond
              ((looking-at "left\\b")
               (setq count (+ count LaTeX-left-right-indent-level)))
              ((looking-at "right\\b")
               (setq count (- count LaTeX-left-right-indent-level)))
              ((looking-at LaTeX-begin-regexp)
               (setq count (+ count LaTeX-indent-level)))
              ((looking-at "else\\b"))
              ((looking-at LaTeX-end-regexp)
               (setq count (- count LaTeX-indent-level)))
              ((looking-at (regexp-quote TeX-esc))
               (forward-char 1))))
           count))))
   (flyspell-buffer)
   )
  )
