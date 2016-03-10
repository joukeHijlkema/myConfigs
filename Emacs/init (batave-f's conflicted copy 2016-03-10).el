(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))


;; Beautifiers
(add-to-list 'load-path "~/.emacs.d/emacs-uncrustify-mode/")
(require 'uncrustify-mode)
  (add-hook 'c-mode-common-hook 
   '(lambda ()
      (uncrustify-mode 1)))

;; My keybindings
(load "~/.emacs.d/keys.el")

(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (tango-dark)))
 '(global-linum-mode t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(show-paren-mode t)
 '(tabbar-mode t nil (tabbar)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 101 :width normal)))))

;; Multiple cursors
;;(add-to-list 'load-path "~/.emacs.d/elpa/multiple-cursors-20160304.659")
;;(require 'multiple-cursors)


;; Snippets
(add-to-list 'load-path
                "~/.emacs.d/elpa/yasnippet-20160226.1359")
   (require 'yasnippet)
   (yas-global-mode 1)
