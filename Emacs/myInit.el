(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))

(tabbar-mode t)
(yas-global-mode t)
(setq tramp-default-method "ssh")
(setq speedbar-initial-expansion-list-name "buffers")

(autoload 'cflow-mode "cflow-mode")
     (setq auto-mode-alist (append auto-mode-alist
                                   '(("\\.cflow$" . cflow-mode))))

(require 'xcscope)

(load "~/.emacs.d/keys.el")
(load"~/.emacs.d/Languages/Python.el")
(load"~/.emacs.d/Languages/C++.el")

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
