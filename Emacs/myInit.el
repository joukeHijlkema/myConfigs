;; === THIS STILL NEEDS TO BE MOVED TO use-package ===
;; (add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
;; (add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
;; (add-to-list 'auto-mode-alist '("\\.FCMacro\\'" . python-mode))


;; === Yas ===
(load "~/.emacs.d/myConfig/myYas.el")
;; === Web mode ===
(load "~/.emacs.d/myConfig/myWeb.el")
;; === Workgroups ===
(load "~/.emacs.d/myConfig/myWg.el")
;; === line numbers off for certain modes ===
(load "~/.emacs.d/myConfig/myLinum-off.el")
;; === langtool ===
(load "~/.emacs.d/myConfig/myLangtool.el")
;; === autoComplete ===
(load "~/.emacs.d/myConfig/myAutoComplete.el")
;; === Latex  ===
(load "~/.emacs.d/myConfig/myLatex.el")
;; === Org mode ===
(load "~/.emacs.d/myConfig/myOrg.el")
;; === mail ===
(when (string= system-name "LDMPE705H") (load "~/.emacs.d/mu4e.el"))
(when (string= system-name "LDMPE709H") (load "~/.emacs.d/mu4e.el"))
;; === keys ===
(load "~/.emacs.d/myConfig/myKeys.el")
;; === Dired ===
(load "~/.emacs.d/myConfig/myDired.el")
;; === Open with ===
(load "~/.emacs.d/myConfig/myOpenWith.el")
;; === python ===
(load "~/.emacs.d/myConfig/myPython.el")
;; === Java ===
;; (load "~/.emacs.d/java.el")
;; === Android development ===
(load "~/.emacs.d/myConfig/myAndroid.el")

;; some global stuff
(tool-bar-mode -1)
(setq tramp-default-method "ssh")
(setq browse-url-browser-function 'browse-url-default-browser)

(add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-vc-set-filter-groups-by-vc-root)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic))))

(setq set-language-environment "utf-8")
(define-coding-system-alias 'UTF-8 'utf-8)
(set-default-coding-systems 'utf-8)

(setq ecb-tip-of-the-day nil)
(custom-set-variables '(ecb-options-version "2.50"))

(show-paren-mode 1)

(server-start)
