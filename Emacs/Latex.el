(use-package latex
  :ensure auctex
  ;; :after ispell
  :mode
  ("\\.tex\\'" . latex-mode)
  :init
  (message "== start init latex")
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
  (defun pasteFromTablet ()
    (interactive)
    (let* ((choices '("equation" "none"))
	   (raw (string-trim (shell-command-to-string "/home/hylkema/Programs/Tools/Python/adbPaste.py")))
	   (choice  (ido-completing-read "Environment:" choices )))
      (print choice)
      (pcase choice
	("equation" (setq fmt "\\begin{equation}\n%s\\end{equation}"))
	(otherwise (setq fmt "%s"))
	)
      (with-current-buffer (window-buffer (selected-window)) (insert (format fmt raw)))))


  (setq org-latex-to-mathml-convert-command
        "latexmlmath \"%i\" --presentationmathml=%o")
  
  (defun jouke_export_latex_function ()
    (interactive)
    (let ((eq (buffer-substring (mark) (point))))
      (with-temp-file "/tmp/eq.tex"
        (insert "\\documentclass[crop=true,border=1pt,convert=true]{standalone}")
        (insert "\\batchmode")
        (insert "\\usepackage[utf8]{inputenc}")
        (insert "\\usepackage{amsmath}")
        (insert "\\makeatletter")
        (insert "\\renewcommand\\tagform@[1]{}")
        (insert "\\makeatother")
        (insert "\\begin{document}")
        (insert eq)
        (insert "\\end{document}")
        )
      (shell-command "cd /tmp ; pdflatex -shell-escape -halt-on-error eq.tex ; pdf2svg eq.pdf eq.svg")
      )
    )
  
  :config
  (message "== start config latex")
  (require 'ido)
  (prettify-symbols-mode)
  (LaTeX-math-mode)
  (reftex-mode)
  (reftex-isearch-minor-mode)
  (turn-off-auto-fill)
  (visual-line-mode)
  (flyspell-mode)
  (flyspell-buffer)
  (message "== end config latex")
  
  :custom
  (message "== start custom latex")
  (ispell-dictionary "fr")
  (default fill-column 120)
  (font-latex-fontify-script nil)
  (font-latex-fontify-sectioning '1.1)
  (TeX-parse-self t)
  (TeX-save-query nil)
  (TeX-PDF-mode t)
  (LaTeX-eqnarray-label "eq")
  (LaTeX-equation-label "eq")
  (LaTeX-figure-label "fig")
  (LaTeX-table-label "tab")
  (LaTeX-myChapter-label "chap")
  (TeX-auto-save t)
  (TeX-newline-function 'reindent-then-newline-and-indent)
  (TeX-parse-self t)
  (TeX-style-path '("style/" "auto/"
                    "/usr/share/emacs21/site-lisp/auctex/style/"
                    "/var/lib/auctex/emacs21/"
                    "/usr/local/share/emacs/site-lisp/auctex/style/"))
  (LaTeX-section-hook '(LaTeX-section-heading
                        LaTeX-section-title
                        LaTeX-section-toc
                        LaTeX-section-section
                        LaTeX-section-label))
  (reftex-plug-into-AUCTeX t)
  (outline-minor-mode 1)
  (turn-on-outline-minor-mode t)
  (LaTeX-begin-regexp "\\(?:begin\\|if@\\|ifx\\|ifnum\\|ifONERA@\\)\\b")
  (LaTeX-end-regexp "\\(?:end\\|else\\|fi\\)\\b")
  (LaTeX-item-indent 1)
  (LaTeX-indent-level 1)
  (openwith-mode nil)
  (reftex-toc-split-windows-horizontally t)
  (reftex-toc-split-windows-fraction 0.25)
  (message "== end custom latex")
  :hook
  (LaTeX-mode . (lambda ()
                  (message "== latex hook")
                  (prettify-symbols-mode)
                  (LaTeX-math-mode)
                  (reftex-mode)
                  (reftex-isearch-minor-mode)
                  (turn-off-auto-fill)
                  (visual-line-mode)
                  (flyspell-mode)
                  (flyspell-buffer)
		  ))
  :bind
  ("s-p" . pasteFromTablet)
  )
