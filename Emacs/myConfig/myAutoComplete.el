(use-package company
  :ensure t
  :hook web-mode
  :init (global-company-mode)
  )

;; (use-package auto-complete
;;   :ensure t
;;   :init (message "=== my init auto-complete")
;;   (defun my-ac-latex-mode () ; add ac-sources for latex
;;     (setq ac-sources
;;           (append '(ac-source-math-unicode
;;             ac-source-math-latex
;;             ac-source-latex-commands)
;;                   ac-sources)))
;;   :config
;;   (setq ac-auto-start t)
;;   (setq ac-modes
;; 	(quote
;; 	 (latex-mode emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode nim-mode c-mode cc-mode c++-mode objc-mode swift-mode go-mode java-mode malabar-mode clojure-mode clojurescript-mode scala-mode scheme-mode ocaml-mode tuareg-mode coq-mode haskell-mode agda-mode agda2-mode perl-mode cperl-mode python-mode ruby-mode lua-mode tcl-mode ecmascript-mode javascript-mode js-mode js-jsx-mode js2-mode js2-jsx-mode coffee-mode php-mode css-mode scss-mode less-css-mode elixir-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode web-mode ts-mode sclang-mode verilog-mode qml-mode apples-mode)))
;;   (add-to-list 'ac-modes 'latex-mode)
;;   (ac-flyspell-workaround)
;;   (add-to-list 'ac-modes 'org-mode)
;;   (ac-config-default)
;;   )
;; (use-package auto-complete-config
;;   :ensure t
;;   :config
;;   (ac-config-default)
;;   (setq ac-auto-start nil)
;;   (setq ac-auto-show-menu t)
;;   (global-auto-complete-mode t)
;;   )
;; (use-package ac-math
;;   :ensure t
;;   :config
;;   (setq ac-math-unicode-in-math-p t)
;;   )


;;; auto-complete setup, sequence is important
;; (require 'auto-complete)
;; (add-to-list 'ac-modes 'latex-mode) ; beware of using 'LaTeX-mode instead
;; (require 'ac-math) ; package should be installed first 
;; (defun my-ac-latex-mode () ; add ac-sources for latex
;;    (setq ac-sources
;;          (append '(ac-source-math-unicode
;;            ac-source-math-latex
;;            ac-source-latex-commands)
;;                  ac-sources)))
;; (add-hook 'LaTeX-mode-hook 'my-ac-latex-mode()
;; (setq ac-math-unicode-in-math-p t)
;; (ac-flyspell-workaround)          ; fixes a known bug of delay due to flyspell (if it is there)
;; (add-to-list 'ac-modes 'org-mode) ; auto-complete for org-mode (optional)
;; (require 'auto-complete-config)   ; should be after add-to-list 'ac-modes and hooks
;; (ac-config-default)
;; (setq ac-auto-start nil)            ; if t starts ac at startup automatically
;; (setq ac-auto-show-menu t)
;; (global-auto-complete-mode t) 

