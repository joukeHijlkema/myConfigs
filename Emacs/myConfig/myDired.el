(use-package dired
  :init
  (message "=== my init dired")
  (defun myOpenFileInWg ()
  (interactive)
  (let* ((fileName (dired-copy-filename-as-kill))
         (dirName dired-directory)
         (wg (read-number "Workgroup:"))
         )
    (message "wg = %s" wg)
    (wg-switch-to-workgroup-at-index wg)
    (find-file (format "%s/%s" dirName fileName))
    )
  )
  (defun dired-dotfiles-toggle ()
    "Show/hide dot-files"
    (interactive)
    (when (equal major-mode 'dired-mode)
      (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
	  (progn 
	    (set (make-local-variable 'dired-dotfiles-show-p) nil)
	    (message "h")
	    (dired-mark-files-regexp "^\\\.")
	    (dired-do-kill-lines))
	(progn (revert-buffer) ; otherwise just revert to re-show
	       (set (make-local-variable 'dired-dotfiles-show-p) t)))))
  
  (message "=== done init dired")
  :config
  (setq dired-dwim-target t)
  :hook
  (dired-mode . (lambda ()
                  (message "== dired hook ==")
                  (openwith-mode t)))
  :bind
  ("s-=" . 'dired-other-window)
  ("s-o" . 'myOpenFileInWg)
  ("s-." . 'dired-dotfiles-toggle)
  )
