(require 'dired-x)
(setq-default dired-omit-files-p t) ; Buffer-local variable
(setq dired-omit-files (concat dired-omit-files  "^\.+.+\|^\.?#\|^\.$\|^\.\.$"))

(eval-after-load "sunrise" '(progn
			      (define-key sunrise-mode-map [mouse-1]        nil)
			      (define-key sunrise-mode-map [mouse-movement] nil)
			      (require 'openwith)
			      )
		 )

(defun jouke-switch-to-sunrise ()
  (interactive)
  (ignore-errors (wg-switch-to-workgroup-at-index-4))
  (sunrise 1)
  )
