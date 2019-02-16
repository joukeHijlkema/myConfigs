;; remove toolbar
(tool-bar-mode -1)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.FCMacro\\'" . python-mode))

;; (tabbar-mode t)
(yas-global-mode t)
(setq tramp-default-method "ssh")
(setq speedbar-initial-expansion-list-name "buffers")

(autoload 'cflow-mode "cflow-mode")
(setq auto-mode-alist (append auto-mode-alist '(("\\.cflow$" . cflow-mode))))

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


(add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-vc-set-filter-groups-by-vc-root)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic))))

(require 'use-package)
;; Workgroups2
(require 'workgroups2)
(workgroups-mode 1)
(setq wg-emacs-exit-save-behavior           'save)      ; Options: 'save 'ask nil
(setq wg-workgroups-mode-exit-save-behavior 'save)      ; Options: 'save 'ask nil

;; === firefox as browser ===
(setq browse-url-browser-function 'browse-url-firefox)

;; === line numbers off for certain modes ===
(load "~/.emacs.d/linum-off.el")
;; === langtool ===
(load "~/.emacs.d/langtool.el")
;; === autoComplete ===
(load "~/.emacs.d/autoComplete.el")
;; === Latex  ===
(load "~/.emacs.d/Latex.el")
;; === Org mode ===
(load "~/.emacs.d/momMode.el")
;; === mail ===
(when (string= system-name "LDMPE705H") (load "~/.emacs.d/mu4e.el"))
(when (string= system-name "LDMPE709H") (load "~/.emacs.d/mu4e.el"))
;; (load "~/.emacs.d/nevermore.el")
;;(load "~/.emacs.d/notmuch.el")
;; === keys ===
(load "~/.emacs.d/keys.el")
;; === sunrine ===
;; (load "~/.emacs.d/mySunrise.el")
;; === Dired ===
(load "~/.emacs.d/Dired.el")
;; === Open with ===
(load "~/.emacs.d/openWith.el")
;; (load "~/.emacs.d/myTheme.el")
;; === java ===
;; (load "~/.emacs.d/java.el")
;; === python ===
(load "~/.emacs.d/python.el")

;;; auto-complete setup, sequence is important
(require 'auto-complete)
(add-to-list 'ac-modes 'latex-mode) ; beware of using 'LaTeX-mode instead
(require 'ac-math) ; package should be installed first 
(defun my-ac-latex-mode () ; add ac-sources for latex
   (setq ac-sources
         (append '(ac-source-math-unicode
           ac-source-math-latex
           ac-source-latex-commands)
                 ac-sources)))
(add-hook 'LaTeX-mode-hook 'my-ac-latex-mode)
(setq ac-math-unicode-in-math-p t)
(ac-flyspell-workaround)          ; fixes a known bug of delay due to flyspell (if it is there)
(add-to-list 'ac-modes 'org-mode) ; auto-complete for org-mode (optional)
(require 'auto-complete-config)   ; should be after add-to-list 'ac-modes and hooks
(ac-config-default)
(setq ac-auto-start nil)            ; if t starts ac at startup automatically
(setq ac-auto-show-menu t)
(global-auto-complete-mode t) 

(setq set-language-environment "utf-8")
(define-coding-system-alias 'UTF-8 'utf-8)
(set-default-coding-systems 'utf-8)

(setq ecb-tip-of-the-day nil)
(custom-set-variables '(ecb-options-version "2.50")) 

