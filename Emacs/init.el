(when (or (string= system-name "CFM-WDMAE007H") (string= system-name "batave-f"))
  (setq url-proxy-services
	'(("no_proxy" . "^\\(localhost\\|10.*\\)")
	  ("http" . "minos.onecert.fr:80")
	  ("https" . "minos.onecert.fr:80"))))

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-start t)
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (tango-dark)))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(minimap-mode nil)
 '(minimap-window-location (quote left))
 '(org-agenda-file-regexp ".*\\.org$")
 '(org-agenda-files (quote ("~/Documents/Org")))
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "/usr/bin/qpdfview"))))
 '(org-log-done (quote note))
 '(package-selected-packages
   (quote
    (org-journal markdown-preview-eww markdown-mode ibuffer-projectile ibuffer-vc projectile-codesearch projectile-git-autofetch projectile-speedbar zephir-mode projectile dh-elpa wsd-mode web-mode virtualenv uncru stify-mode tabbar-ruler sr-speedbar pyvenv python-environment plantuml-mode php+-mode multiple-cursors minimap magit highlight-indentation gnuplot-mode gnuplot flycheck find-file-in-project epc egg ecb direx com pany-irony-c-headers company-irony clang-format auto-install auctex-lua auctex-latexmk)))
 '(show-paren-mode t)
 '(speedbar-sort-tags t)
 '(speedbar-tag-hierarchy-method
   (quote
    (speedbar-prefix-group-tag-hierarchy speedbar-trim-words-tag-hierarchy speedbar-sort-tag-hierarchy)))
 '(virtualenv-root "~hylkema/")
 '(wg-morph-on nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 101 :width normal)))))
(put 'upcase-region 'disabled nil)

;;<<<<<<< HEAD
;; load calendar at start
;; (calendar)
;;=======
(put 'downcase-region 'disabled nil)

(load "~/.emacs.d/myInit.el")

;;>>>>>>> 5e4b582b9f5409fdd2dc135622e5dc48e0a3628c
