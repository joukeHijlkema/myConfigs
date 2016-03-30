(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))

(tabbar-mode t)
(setq tramp-default-method "ssh")
(setq speedbar-initial-expansion-list-name "buffers")

(load "~/.emacs.d/keys.el")
(load"~/.emacs.d/Languages/Python.el")
(load"~/.emacs.d/Languages/C++.el")
