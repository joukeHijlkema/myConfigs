;; copy paste behaviour
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) 	      ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t)   ;; Standard Windows

;; Multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Deletion,formating etc
(global-set-key (kbd "C-k") 'kill-whole-line)

(defun duplicate-line()
  "duplicate line"
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))
(global-set-key (kbd "C-d") 'duplicate-line)

(global-set-key (kbd "C-r") 'rectangle-mark-mode)
(global-set-key (kbd "C-a") 'align-current)

;; commenting
(defun toggle-comment-on-line (beg end)
  "comment or uncomment current line or region"
  (interactive (if (use-region-p)
		   (list (region-beginning) (region-end))
		 (list (line-beginning-position) (line-end-position))))
  (comment-or-uncomment-region beg end))
(global-set-key (kbd "C-e") 'toggle-comment-on-line)

;; speedbar
(global-set-key (kbd "C-c C-o") 'sr-speedbar-toggle)
(global-set-key (kbd "C-c C-b") (lambda() (interactive) (speedbar-change-initial-expansion-list "quick buffers")))
(global-set-key (kbd "C-c C-f") (lambda() (interactive) (speedbar-change-initial-expansion-list "files")))
