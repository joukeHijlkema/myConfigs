(when (or (string= system-name "CFM-WDMAE007H") (string= system-name "batave-f"))
  (setq url-proxy-services
	'(("no_proxy" . "^\\(localhost\\|10.*\\)")
	  ("http" . "minos.onecert.fr:80")
	  ("https" . "minos.onecert.fr:80"))))

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default default default italic underline success warning error])
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (tango-dark)))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 101 :width normal)))))

;; this is needed to load tabbar after automatic packaging is done
(add-hook 'after-init-hook 'my-after-init-hook)
(defun my-after-init-hook ()
  '(tabbar-mode t nil (tabbar))
  ;; My keybindings
  (load "~/.emacs.d/keys.el"))


