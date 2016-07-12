;; copy paste behaviour
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) 	      ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t)   ;; Standard Windows

;; Multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "s->") 'mc/mark-next-like-this)
(global-set-key (kbd "s-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-s-<") 'mc/mark-all-like-this)
;; Deletion etc
(global-set-key (kbd "s-k") 'kill-whole-line)

(defun duplicate-line-or-region(p0 ps pe)
  "duplicate line or region"
  (interactive
   (if (use-region-p)
       (list (point) (region-beginning) (region-end))
     (list (point) (line-beginning-position) (line-end-position))))
  (goto-char pe)
  (if (eq pe (line-end-position))
      (setq add "\n")
    (setq add ""))
  (kill-region pe ps)
  (yank)
  (goto-char pe)
  (insert add)
  (yank)
  (goto-char p0)
  )

(global-set-key (kbd "s-d") 'duplicate-line-or-region)
(global-set-key (kbd "s-r") 'rectangle-mark-mode)
(global-set-key (kbd "s-a") 'align-current)

;; commenting
(defun toggle-comment-on-line (beg end)
  "comment or uncomment current line or region"
  (interactive (if (use-region-p)
		   (list (region-beginning) (region-end))
		 (list (line-beginning-position) (line-end-position))))
  (comment-or-uncomment-region beg end))
(global-set-key (kbd "s-e") 'toggle-comment-on-line)

;; speedbar
(global-set-key (kbd "s-o") 'sr-speedbar-toggle)
(global-set-key (kbd "s-b") (lambda() (interactive) (speedbar-change-initial-expansion-list "quick buffers")))
(global-set-key (kbd "s-f") (lambda() (interactive) (speedbar-change-initial-expansion-list "files")))

;; uncrustify
(global-set-key (kbd "s-u") 'uncrustify-buffer)
