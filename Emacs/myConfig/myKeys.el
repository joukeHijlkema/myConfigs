;; copy paste behaviour
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) 	      ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t)   ;; Standard Windows

;; Multiple cursors
(use-package multiple-cursors
  :ensure t
  :init (message "=== my mc init ===")
  :bind (
         ("C-S-c C-S-c" . mc/edit-lines)
         ("s->" . mc/mark-next-like-this)
         ("s-<" . mc/mark-previous-like-this)
         ("C-s-<" . mc/mark-all-like-this)
         )
  )

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
(use-package uncrustify-mode
  :ensure t
  :init (message "=== my uncrustify-mode init ===")
  (global-set-key (kbd "s-u") 'uncrustify-buffer)
  )

;; Buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

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
(global-set-key (kbd "s-y") 'yas-expand)

(global-set-key (kbd "s-i") (lambda () (interactive)
			      (imenu-list-minor-mode)
			      ))

;; === File completion ===
(fset 'my-complete-file-name
        (make-hippie-expand-function '(try-complete-file-name-partially
                                       try-complete-file-name)))

(global-set-key (kbd "s-f") 'my-complete-file-name)
(use-package magit
  :ensure t
  :init (message "=== my magit init ===")
  (global-set-key (kbd "s-v") 'magit-status))

;; === Tramp ===
(global-set-key (kbd "<s-backspace>") (lambda () (interactive) (tramp-cleanup-all-buffers) (tramp-cleanup-all-connections)))

;; === Bookmarks ===
(global-set-key (kbd "C-s-m") 'bookmark-set)
(global-set-key (kbd "s-m") 'list-bookmarks)

;; === Theme changing ===
(use-package lab-themes
  :ensure t)
(use-package spacemacs-common
  :ensure spacemacs-theme)
(defun changeTheme (TH)
  (setq themes (list 'lab-dark 'lab-light 'spacemacs-dark 'spacemacs-light))
  (dolist (th themes nil) (disable-theme th))
  (load-theme TH))

(global-set-key (kbd "C-&") (lambda () (interactive) (changeTheme 'lab-dark)))
(global-set-key (kbd "C-é") (lambda () (interactive) (changeTheme 'lab-light)))
(global-set-key (kbd "C-\"") (lambda () (interactive) (changeTheme 'spacemacs-dark)))
(global-set-key (kbd "C-'") (lambda () (interactive) (changeTheme 'spacemacs-light)))

;; === Lisp  ===
(global-set-key (kbd "s-*") 'eval-buffer)
