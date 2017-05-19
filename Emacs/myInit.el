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

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'"	.	web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'"	.	web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.xml?\\'"		.	web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'"		.	web-mode))

;; Set up plantuml.
;;
;;

(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t)))

(setq org-plantuml-jar-path
      (setq plantuml-jar-path (expand-file-name "./plantuml.jar")))

;;Auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)
(setq ispell-program-name "aspell")
(setq ispell-dictionary "english") 

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(defun turn-on-outline-minor-mode ()
(outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else

(require 'tex-site)
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
;; (add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(setq LaTeX-eqnarray-label "eq"
LaTeX-equation-label "eq"
LaTeX-figure-label "fig"
LaTeX-table-label "tab"
LaTeX-myChapter-label "chap"
TeX-auto-save t
TeX-newline-function 'reindent-then-newline-and-indent
TeX-parse-self t
TeX-style-path
'("style/" "auto/"
"/usr/share/emacs21/site-lisp/auctex/style/"
"/var/lib/auctex/emacs21/"
"/usr/local/share/emacs/site-lisp/auctex/style/")
LaTeX-section-hook
'(LaTeX-section-heading
LaTeX-section-title
LaTeX-section-toc
LaTeX-section-section
LaTeX-section-label))

;; Close all the buffers
(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

