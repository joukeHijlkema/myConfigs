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

(defun mydate () (interactive)
       (insert (shell-command-to-string "echo -n $(date +%d/%m/%Y) ")))

(global-set-key (kbd "s-d") 'duplicate-line-or-region)
(global-set-key (kbd "s-r") 'rectangle-mark-mode)
(global-set-key (kbd "s-a") 'align-current)
(global-set-key (kbd "s-z") 'ff-find-other-file)
(global-set-key (kbd "s-t") 'mydate)

;; commenting
(defun toggle-comment-on-line (beg end)
  "comment or uncomment current line or region"
  (interactive (if (use-region-p)
		   (list (region-beginning) (region-end))
		 (list (line-beginning-position) (line-end-position))))
  (comment-or-uncomment-region beg end))
(global-set-key (kbd "s-e") 'toggle-comment-on-line)

;; uncrustify
(require 'uncrustify-mode)
(global-set-key (kbd "s-u") 'uncrustify-buffer)

;; Buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;workgroups
(setq wg-prefix-key (kbd "C-c w"))
(global-set-key (kbd "s-<kp-0>") 'wg-switch-to-workgroup-at-index-0)
(global-set-key (kbd "s-<kp-1>") 'wg-switch-to-workgroup-at-index-1)
(global-set-key (kbd "s-<kp-2>") 'wg-switch-to-workgroup-at-index-2)
(global-set-key (kbd "s-<kp-3>") 'wg-switch-to-workgroup-at-index-3)
(global-set-key (kbd "s-<kp-4>") 'wg-switch-to-workgroup-at-index-4)
(global-set-key (kbd "s-<kp-5>") 'wg-switch-to-workgroup-at-index-5)
(global-set-key (kbd "s-<kp-6>") 'wg-switch-to-workgroup-at-index-6)
(global-set-key (kbd "s-<kp-7>") 'wg-switch-to-workgroup-at-index-7)
(global-set-key (kbd "s-<kp-8>") 'wg-switch-to-workgroup-at-index-8)
(global-set-key (kbd "s-<kp-9>") 'wg-switch-to-workgroup-at-index-9)
(global-set-key (kbd "s-0") 'wg-switch-to-workgroup-at-index-0)
(global-set-key (kbd "s-1") 'wg-switch-to-workgroup-at-index-1)
(global-set-key (kbd "s-2") 'wg-switch-to-workgroup-at-index-2)
(global-set-key (kbd "s-3") 'wg-switch-to-workgroup-at-index-3)
(global-set-key (kbd "s-4") 'wg-switch-to-workgroup-at-index-4)
(global-set-key (kbd "s-5") 'wg-switch-to-workgroup-at-index-5)
(global-set-key (kbd "s-6") 'wg-switch-to-workgroup-at-index-6)
(global-set-key (kbd "s-7") 'wg-switch-to-workgroup-at-index-7)
(global-set-key (kbd "s-8") 'wg-switch-to-workgroup-at-index-8)
(global-set-key (kbd "s-9") 'wg-switch-to-workgroup-at-index-9)
(global-set-key (kbd "<s-kp-divide>") 'delete-other-windows)
(global-set-key (kbd "<s-kp-multiply>") 'wg-revert-workgroup)
(global-set-key (kbd "<s-kp-subtract>") 'wg-save-session)

;; window navigation
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)

;; ORG mode
(define-key org-mode-map (kbd "s-i") 'org-clock-in)
(define-key org-mode-map (kbd "s-o") 'org-clock-out)
(define-key org-mode-map (kbd "s-a") 'org-mactions-new-numbered-action)
(define-key org-mode-map  (kbd "<s-f10>") 'jouke-make-beamer-pdf)
(define-key org-mode-map  (kbd "<s-f11>") 'jouke-make-latex)
(define-key org-mode-map  (kbd "<s-f12>") 'jouke-make-pdf)

(global-set-key (kbd "<s-f10>") 'cfw:org-open-agenda-day)

;; === Spelling ===
(global-set-key (kbd "s-s") 'ispell-change-dictionary)
