(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))

(tabbar-mode t)
(setq tramp-default-method "ssh")

(load "~/.emacs.d/keys.el")
