(when (string-match-p "134\.212\.[[:digit:]]+\.[[:digit:]]+"
		      (car (split-string (shell-command-to-string (format "ip:%s" "/bin/hostname -I")))))
  (setq url-proxy-services
	'(("no_proxy" . "^\\(localhost\\|10.*\\|vandales-f.onecert.fr\\)")
	  ("http" . "minos.onecert.fr:80")
	  ("https" . "minos.onecert.fr:80"))
	)
  (message "proxies : %s" url-proxy-services)
  )

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 )
      )

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
;; (setq use-package-verbose 'Debug)

(load "~/.emacs.d/myInit.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "5e515425f8a5ce00097d707742eb5eee09b27cebc693b8998c734305cbdce1f5" "d14d421ff49120d2c2e0188bcef76008407b3ceff2cfb1d4bdf3684cf3190172" default)))
 '(ecb-options-version "2.50")
 '(package-selected-packages
   (quote
    (sr-speedbar tabbar zephir-mode yasnippet-snippets yapfify wsd-mode workgroups2 web-mode wanderlust w3m use-package uncrustify-mode treemacs traad tabbar-ruler sunrise-x-tree sunrise-x-tabs sunrise-x-popviewer sunrise-x-modeline sunrise-x-mirror sunrise-x-loop sunrise-x-checkpoints sunrise-x-buttons spacemacs-theme smartparens realgud py-yapf py-autopep8 projectile-speedbar projectile-git-autofetch projectile-codesearch plantuml-mode pdf-tools org-plus-contrib org-kanban org-journal org-agenda-property openwith nm neotree multiple-cursors mu4e-query-fragments mu4e-maildirs-extension mu4e-jump-to-list mu4e-alert moe-theme minimap markdown-preview-eww markdown-mode magit latex-preview-pane langtool lab-themes jedi-direx jdee imenu-list ibuffer-vc ibuffer-projectile gradle-mode gnuplot-mode gnuplot flycheck-gradle flatui-theme elpy ecb dracula-theme doom-themes distinguished-theme dired-subtree dash-functional counsel-org-capture-string counsel company-irony color-identifiers-mode calfw-org calfw-ical calfw-cal calfw auto-complete-auctex auctex-latexmk android-env ample-zen-theme ample-theme alect-themes adaptive-wrap ac-math)))
 '(python-shell-interpreter "python3" t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
