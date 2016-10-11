(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))

(tabbar-mode t)
(yas-global-mode t)
(setq tramp-default-method "ssh")
(setq speedbar-initial-expansion-list-name "buffers")

(yas-global-mode t)
(autoload 'cflow-mode "cflow-mode")
     (setq auto-mode-alist (append auto-mode-alist
                                   '(("\\.cflow$" . cflow-mode))))

(require 'xcscope)

(load "~/.emacs.d/keys.el")
(load"~/.emacs.d/Languages/Python.el")
(load"~/.emacs.d/Languages/C++.el")
