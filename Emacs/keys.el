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
(global-set-key (kbd "s-b") 'ibuffer)

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
(global-set-key (kbd "s-z") 'ff-find-other-file)
(global-set-key (kbd "s-t") 'mydate)


;; Align mode
(global-set-key (kbd "s-a") 'align-current)
(global-set-key (kbd "C-s-a") 'align-regexp)

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
(global-set-key (kbd "s-<kp-9>") 'jouke-switch-to-cal)
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

(global-set-key (kbd "<s-f7>") 'sunrise)
(global-set-key (kbd "<s-f6>") 'mu4e)
(when (string= system-name "LDMPE705H")
  (global-set-key (kbd "<XF86Mail>") 'mu4e)
  )

;; === Spelling ===
(defun toggleSpelling ()
  (interactive)
  (if (string-equal ispell-current-dictionary "british-ise")
    (ispell-change-dictionary "francais")
    (ispell-change-dictionary "british-ise"))
  (flyspell-buffer)
  )

(global-set-key (kbd "s-s") 'toggleSpelling)

;; === yasnippets (conflicts with completion) ===
(global-set-key (kbd "<backtab>") 'yas-expand)

(global-set-key (kbd "s-i") (lambda () (interactive)
			      (imenu-list-minor-mode)
			      ))

;; === File completion ===
(fset 'my-complete-file-name
        (make-hippie-expand-function '(try-complete-file-name-partially
                                       try-complete-file-name)))

(global-set-key (kbd "s-f") 'my-complete-file-name) 
(global-set-key (kbd "s-v") 'magit-status)

;; === Tramp ===
(global-set-key (kbd "<s-backspace>") (lambda () (interactive) (tramp-cleanup-all-buffers) (tramp-cleanup-all-connections)))

;; === Bookmarks ===
(global-set-key (kbd "C-s-m") 'bookmark-set)
(global-set-key (kbd "s-m") 'list-bookmarks)

;; === Theme changing ===
(defun changeTheme (TH)
  (setq themes (list 'lab-dark 'lab-light 'spacemacs-dark 'spacemacs-light))
  (dolist (th themes nil) (disable-theme th))
  (load-theme TH))
(global-set-key (kbd "C-&") (lambda () (interactive) (changeTheme 'lab-dark)))
(global-set-key (kbd "C-é") (lambda () (interactive) (changeTheme 'lab-light)))
(global-set-key (kbd "C-\"") (lambda () (interactive) (changeTheme 'spacemacs-dark)))
(global-set-key (kbd "C-'") (lambda () (interactive) (changeTheme 'spacemacs-light)))

