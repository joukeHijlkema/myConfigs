(when (or (string= system-name "CFM-WDMAE007H") (string= system-name "batave-f"))
  (setq url-proxy-services
	'(("no_proxy" . "^\\(localhost\\|10.*\\)")
	  ("http" . "minos.onecert.fr:80")
	  ("https" . "minos.onecert.fr:80"))))

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(load "~/.emacs.d/myInit.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (tango-dark)))
 '(ecb-auto-activate t)
 '(ecb-layout-name "left3")
 '(ecb-layout-window-sizes
   (quote
    (("left3"
      (ecb-directories-buffer-name 0.11895910780669144 . 0.29850746268656714)
      (ecb-sources-buffer-name 0.11895910780669144 . 0.34328358208955223)
      (ecb-methods-buffer-name 0.11895910780669144 . 0.3582089552238806)))))
 '(ecb-options-version "2.50")
 '(ecb-source-path (quote (("/" "/") "/home/hylkema/Programs/Hop/Python/V2")))
 '(ede-project-directories
   (quote
    ("/home/hylkema/Programs/Sphinx/Readers" "/home/hylkema/Programs/Test")))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(minimap-mode t)
 '(minimap-window-location (quote right))
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "/usr/bin/qpdfview"))))
 '(show-paren-mode t)
 '(speedbar-sort-tags nil)
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

(ecb-activate)
(setq ecb-tip-of-the-day nil)

(minimap-mode)
