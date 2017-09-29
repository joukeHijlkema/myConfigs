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
(global-set-key (kbd "s-z") 'ff-find-other-file)

;; commenting
(defun toggle-comment-on-line (beg end)
  "comment or uncomment current line or region"
  (interactive (if (use-region-p)
		   (list (region-beginning) (region-end))
		 (list (line-beginning-position) (line-end-position))))
  (comment-or-uncomment-region beg end))
(global-set-key (kbd "s-e") 'toggle-comment-on-line)

;; speedbar
;; open a new speedbar frame if there isn't one already
(global-ede-mode 1)
(require 'semantic/sb)
(semantic-mode 1)
(require 'sr-speedbar)
(global-set-key (kbd "s-s") 'sr-speedbar-toggle)
(global-set-key (kbd "s-b") (lambda() (interactive) (speedbar-change-initial-expansion-list "quick buffers")))
(global-set-key (kbd "s-f") (lambda() (interactive) (speedbar-change-initial-expansion-list "files")))

;; uncrustify
(require 'uncrustify-mode)
(global-set-key (kbd "s-u") 'uncrustify-buffer)

;; Buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;workgroups
(setq wg-prefix-key (kbd "C-c w"))
(global-set-key (kbd "s-<kp-5>") 'wg-revert-workgroup)
(global-set-key (kbd "s-<kp-0>") 'delete-other-windows)

;; window navigation
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)

;; ORG mode
(add-hook 'org-mode-hook 
          (lambda ()
            (local-set-key (kbd "s-a") 'org-mactions-new-numbered-action)
           ))
