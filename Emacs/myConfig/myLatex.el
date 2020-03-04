(use-package ispell)
(message "ispell done")
(use-package reftex
  :commands turn-on-reftex
  :config
  (setq reftex-plug-into-AUCTeX t)
  (setq reftex-toc-split-windows-horizontally t)
  (setq reftex-toc-split-windows-fraction 0.25)
  )
(use-package auctex
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
    (let* ((choices '("equation" "img" "none"))
           (raw (string-trim (shell-command-to-string "~/Programs/Tools/Python/adbPaste.py")))
           (choice  (ido-completing-read "Environment:" choices )))
      (print choice)
      (pcase choice
        ("equation" (setq fmt "\\begin{equation}\n%s\\end{equation}"))
        ("img" (setq fmt "%s"))
        (otherwise (setq fmt "%s"))
        )
      (with-current-buffer (window-buffer (selected-window)) (insert (format fmt raw)))))

  ;; (require 'ido)
  (setq safe-local-variable-values
        '((TeX-command-extra-options . "-shell-escape -synctex=1")
          (TeX-command-extra-options . "-shell-escape")))
  (message "== end init latex")
  
  ;; :config
  (message "== start config latex")
  (setq ispell-dictionary "fr")
  (setq TeX-parse-self t)
  (setq TeX-save-query nil)
  (setq TeX-auto-save t)
  (setq TeX-newline-function 'reindent-then-newline-and-indent)
  (setq TeX-style-path '("style/" "auto/"
                     "/usr/share/emacs21/site-lisp/auctex/style/"
                     "/var/lib/auctex/emacs21/"
                     "/usr/local/share/emacs/site-lisp/auctex/style/"))
  ;; (LaTeX-section-hook '(LaTeX-section-heading
  ;;                       LaTeX-section-title
  ;;                       LaTeX-section-toc
  ;;                       LaTeX-section-section
  ;;                       LaTeX-section-label))
  (setq LaTeX-begin-regexp "\\(?:begin\\|if@\\|ifx\\|ifnum\\|ifONERA@\\)\\b")
  (setq LaTeX-end-regexp "\\(?:end\\|else\\|fi\\)\\b")
  (setq LaTeX-item-indent 1)
  (setq LaTeX-indent-level 1)
  (setq TeX-view-program-selection
        '(((output-dvi has-no-display-manager)
            "dvi2tty")
           ((output-dvi style-pstricks)
            "dvips and gv")
           (output-dvi "xdvi")
           (output-pdf "PDF Tools")
           (output-html "xdg-open")))
  (setq TeX-source-correlate-method '((dvi . source-specials) (pdf . synctex)))
  (message "== end config latex")
  :hook
  (LaTeX-mode . (lambda ()
                  (message "== latex hook")
                  (prettify-symbols-mode)
                  (LaTeX-math-mode)
                  (turn-on-reftex)
                  (reftex-isearch-minor-mode)
                  (turn-off-auto-fill)
                  (visual-line-mode)
                  (flyspell-mode)
                  (flyspell-buffer)
                  (outline-minor-mode)
                  (TeX-PDF-mode)
                  (TeX-source-correlate-mode)
                  (message "== latex hook done")
		  ))
  :bind (
         (:map latex-mode-map ("s-p" . pasteFromTablet))
         )
  )
