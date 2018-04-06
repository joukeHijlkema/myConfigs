(when (string-match-p "134\.212\.[[:digit:]]+\.[[:digit:]]+"
		      (car (split-string (shell-command-to-string (format "/bin/hostname -I")))))
  (setq url-proxy-services
	'(("no_proxy" . "^\\(localhost\\|10.*\\|vandales-f.onecert.fr\\)")
	  ("http" . "minos.onecert.fr:80")
	  ("https" . "minos.onecert.fr:80"))))

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")
			 ("SC"   . "http://joseito.republika.pl/sunrise-commander/")
			 )
      )
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(dired-omit-files "^\\.+.+\\|^\\.?#\\|^\\.$\\|^\\.\\.$")
 '(doc-view-continuous t)
 '(ede-project-directories
   (quote
    ("/home/hylkema/Programs/rpiCameras" "/home/hylkema/Programs/Tools/Cedre")))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(ispell-dictionary "fr")
 '(minimap-mode nil)
 '(minimap-window-location (quote left))
 '(package-selected-packages
   (quote
    (elpy sunrise-x-w32-addons mc-extras latex-preview-pane latex-pretty-symbols counsel swiper openwith sunrise-commander sunrise-x-buttons sunrise-x-checkpoints sunrise-x-loop sunrise-x-mirror sunrise-x-modeline sunrise-x-popviewer sunrise-x-tabs sunrise-x-tree org-plus-contrib yasnippet-snippets ac-math auto-complete-auctex langtool calfw-org calfw-ical calfw use-package mu4e-alert mu4e-maildirs-extension mu4e-query-fragments w3m wanderlust org-journal markdown-preview-eww markdown-mode ibuffer-projectile ibuffer-vc projectile-codesearch projectile-git-autofetch projectile-speedbar zephir-mode projectile dh-elpa wsd-mode web-mode virtualenv uncru stify-mode tabbar-ruler sr-speedbar pyvenv python-environment plantuml-mode php+-mode multiple-cursors minimap magit highlight-indentation gnuplot-mode gnuplot flycheck find-file-in-project epc egg ecb direx com pany-irony-c-headers company-irony clang-format auto-install auctex-lua auctex-latexmk)))
 '(quote (cua-mode t nil (cua-base)))
 '(reftex-toc-split-windows-horizontally t)
 '(show-paren-mode t)
 '(sr-speedbar-right-side nil)
 '(sr-speedbar-skip-other-window-p t)
 '(tool-bar-mode nil)
 '(virtualenv-root "~hylkema/")
 '(wg-emacs-exit-save-behavior (quote nill))
 '(wg-morph-on nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 101 :width normal))))
 '(ecb-tag-header-face ((t (:background "light salmon"))))
 '(org-agenda-date ((t (:foreground "#c4a06c" :weight bold :height 1.1))))
 '(org-agenda-date-weekend ((t (:foreground "#81a05b" :weight bold :height 1.1))))
 '(tabbar-default ((t (:background "#282c34" :foreground "gray" :height 1.0))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "dark slate gray" :foreground "green yellow" :weight bold))))
 '(tabbar-unselected ((t (:inherit tabbar-default :foreground "medium aquamarine")))))
(put 'upcase-region 'disabled nil)

;; (setq ecb-tip-of-the-day nil)
;; (ecb-activate)

;; (minimap-mode)
(put 'downcase-region 'disabled nil)

(load "~/.emacs.d/myInit.el")

