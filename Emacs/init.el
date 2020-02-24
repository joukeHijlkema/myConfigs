(if (string-match-p "134\.212\.[[:digit:]]+\.[[:digit:]]+" (shell-command-to-string "hostname -I | awk '{print $1}'"))
    (progn
      (setq url-proxy-services
            '(("no_proxy" . "^\\(localhost\\|10.*\\|vandales-f.onecert.fr\\)")
              ("http" . "minos.onecert.fr:80")
              ("https" . "minos.onecert.fr:80"))
            )
      (message "proxies : %s" url-proxy-services)
      )
  (setq url-proxy-services nil))

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
(setq debug-on-error nil)

(setq custom-file "~/.emacs.d/emacs-custom.el")
(load "~/.emacs.d/myInit.el")

