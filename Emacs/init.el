(when (or (string= system-name "CFM-WDMAE007H") (string= system-name "batave-f"))
  (setq url-proxy-services
	'(("no_proxy" . "^\\(localhost\\|10.*\\)")
	  ("http" . "minos.onecert.fr:80")
	  ("https" . "minos.onecert.fr:80"))))

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("elpa"."http://joseito.republika.pl/sunrise-commander/")))

(package-initialize)

(load "~/.emacs.d/myInit.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-start t)
 '(align-rules-list
   (quote
    ((lisp-second-arg
      (regexp . "\\(^\\s-+[^( 	
]\\|(\\(\\S-+\\)\\s-+\\)\\S-+\\(\\s-+\\)")
      (group . 3)
      (modes . align-lisp-modes)
      (run-if .
	      #[0 "\207"
		  [current-prefix-arg]
		  1 "

(fn)"]))
     (lisp-alist-dot
      (regexp . "\\(\\s-*\\)\\.\\(\\s-*\\)")
      (group 1 2)
      (modes . align-lisp-modes))
     (open-comment
      (regexp .
	      #[514 "\211\203 \301\202	 \302\303\304!\305Q\306#\207"
		    [comment-start re-search-backward re-search-forward "[^ 	
\\\\]" regexp-quote "\\(.+\\)$" t]
		    6 "

(fn END REVERSE)"])
      (modes . align-open-comment-modes))
     (c-macro-definition
      (regexp . "^\\s-*#\\s-*define\\s-+\\S-+\\(\\s-+\\)")
      (modes . align-c++-modes))
     (c-variable-declaration
      (regexp . "[*&0-9A-Za-z_]>?[&*]*\\(\\s-+[*&]*\\)[A-Za-z_][0-9A-Za-z:_]*\\s-*\\(\\()\\|=[^=
].*\\|(.*)\\|\\(\\[.*\\]\\)*\\)?\\s-*[;,]\\|)\\s-*$\\)")
      (group . 1)
      (modes . align-c++-modes)
      (justify . t)
      (valid .
	     #[0 "\212\301\224b\210\302v\210\303\304!)\206+ \305\300!\203\" \203\" \306`\307\"\310=\202+ \311 \211@@\262\312=?\207"
		 [font-lock-mode 1 -1 looking-at "\\(goto\\|return\\|new\\|delete\\|throw\\)" boundp get-text-property face font-lock-comment-face c-guess-basic-syntax c]
		 3 "

(fn)"]))
     (c-assignment
      (regexp . "[^-=!^&*+<>/| 	
]\\(\\s-*[-=!^&*+<>/|]*\\)=\\(\\s-*\\)\\([^= 	
]\\|$\\)")
      (group 1 2)
      (modes . align-c++-modes)
      (justify . t)
      (tab-stop))
     (perl-assignment
      (regexp . "[^=!^&*-+<>/| 	
]\\(\\s-*\\)=[~>]?\\(\\s-*\\)\\([^>= 	
]\\|$\\)")
      (group 1 2)
      (modes . align-perl-modes)
      (tab-stop))
     (python-assignment
      (regexp . "[^=!<>]\\(\\s-*\\)\\([\\+-]?\\)=\\(\\s-*\\)\\([^>=]\\|$\\)")
      (group 1 2 3)
      (modes quote
	     (python-mode))
      (tab-stop))
     (make-assignment
      (regexp . "^\\s-*\\w+\\(\\s-*\\):?=\\(\\s-*\\)\\([^	
 \\\\]\\|$\\)")
      (group 1 2)
      (modes quote
	     (makefile-mode))
      (tab-stop))
     (c-comma-delimiter
      (regexp . ",\\(\\s-*\\)[^/ 	
]")
      (repeat . t)
      (modes . align-c++-modes)
      (run-if .
	      #[0 "\207"
		  [current-prefix-arg]
		  1 "

(fn)"]))
     (basic-comma-delimiter
      (regexp . ",\\(\\s-*\\)[^# 	
]")
      (repeat . t)
      (modes append align-perl-modes
	     (quote
	      (python-mode)))
      (run-if .
	      #[0 "\207"
		  [current-prefix-arg]
		  1 "

(fn)"]))
     (c++-comment
      (regexp . "\\(\\s-*\\)\\(//.*\\|/\\*.*\\*/\\s-*\\)$")
      (modes . align-c++-modes)
      (column . comment-column)
      (valid .
	     #[0 "\212\300\224b\210n)?\207"
		 [1]
		 1 "

(fn)"]))
     (c-chain-logic
      (regexp . "\\(\\s-*\\)\\(&&\\|||\\|\\<and\\>\\|\\<or\\>\\)")
      (modes . align-c++-modes)
      (valid .
	     #[0 "\212\300\225b\210\301\302!)\207"
		 [2 looking-at "\\s-*\\(/[*/]\\|$\\)"]
		 2 "

(fn)"]))
     (perl-chain-logic
      (regexp . "\\(\\s-*\\)\\(&&\\|||\\|\\<and\\>\\|\\<or\\>\\)")
      (modes . align-perl-modes)
      (valid .
	     #[0 "\212\300\225b\210\301\302!)\207"
		 [2 looking-at "\\s-*\\(#\\|$\\)"]
		 2 "

(fn)"]))
     (python-chain-logic
      (regexp . "\\(\\s-*\\)\\(\\<and\\>\\|\\<or\\>\\)")
      (modes quote
	     (python-mode))
      (valid .
	     #[0 "\212\300\225b\210\301\302!)\207"
		 [2 looking-at "\\s-*\\(#\\|$\\|\\\\\\)"]
		 2 "

(fn)"]))
     (c-macro-line-continuation
      (regexp . "\\(\\s-*\\)\\\\$")
      (modes . align-c++-modes)
      (column . c-backslash-column))
     (basic-line-continuation
      (regexp . "\\(\\s-*\\)\\\\$")
      (modes quote
	     (python-mode makefile-mode)))
     (tex-record-separator
      (regexp .
	      #[514 "\300\301#\207"
		    [align-match-tex-pattern "&"]
		    6 "

(fn END REVERSE)"])
      (group 1 2)
      (modes . align-tex-modes)
      (repeat . t))
     (tex-tabbing-separator
      (regexp .
	      #[514 "\300\301#\207"
		    [align-match-tex-pattern "\\\\[=>]"]
		    6 "

(fn END REVERSE)"])
      (group 1 2)
      (modes . align-tex-modes)
      (repeat . t)
      (run-if .
	      #[0 "\301=\207"
		  [major-mode latex-mode]
		  2 "

(fn)"]))
     (tex-record-break
      (regexp . "\\(\\s-*\\)\\\\\\\\")
      (modes . align-tex-modes))
     (text-column
      (regexp . "\\(^\\|\\S-\\)\\([ 	]+\\)\\(\\S-\\|$\\)")
      (group . 2)
      (modes . align-text-modes)
      (repeat . t)
      (run-if .
	      #[0 "\205 \301=?\207"
		  [current-prefix-arg -]
		  2 "

(fn)"]))
     (text-dollar-figure
      (regexp . "\\$?\\(\\s-+[0-9]+\\)\\.")
      (modes . align-text-modes)
      (justify . t)
      (run-if .
	      #[0 "\301=\207"
		  [current-prefix-arg -]
		  2 "

(fn)"]))
     (css-declaration
      (regexp . "^\\s-*\\w+:\\(\\s-*\\).*;")
      (group 1)
      (modes quote
	     (css-mode html-mode))))))
'(ansi-color-faces-vector
[default default default italic underline success warning error])
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (tango-dark)))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(minimap-mode nil)
 '(minimap-window-location (quote left))
 '(org-agenda-files "~/.agenda_files.org")
'(org-file-apps
(quote
 ((auto-mode . emacs)
  ("\\.mm\\'" . default)
  ("\\.x?html?\\'" . default)
  ("\\.pdf\\'" . "/usr/bin/qpdfview"))))
 '(org-log-done (quote note))
 '(show-paren-mode t)
 '(speedbar-sort-tags t)
'(speedbar-tag-hierarchy-method
(quote
 (speedbar-prefix-group-tag-hierarchy speedbar-trim-words-tag-hierarchy speedbar-sort-tag-hierarchy)))
 '(virtualenv-root "~hylkema/"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 101 :width normal)))))
(put 'upcase-region 'disabled nil)
