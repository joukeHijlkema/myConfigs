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
(setq use-package-verbose 'Debug)

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
    (mu4e magit spacemacs-themes company-mode auto-complete-config cua-mode t: android-env workgroups2 web-mode use-package uncrustify-mode tabbar sunrise-x-buttons sr-speedbar spacemacs-theme semi org-plus-contrib org-journal org-edit-latex org openwith multiple-cursors markdown-mode langtool lab-themes hydra elpy ecb dired-explorer calfw-org calfw arduino-mode ac-math)))
 '(python-shell-interpreter "python3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
