;; remove toolbar
(tool-bar-mode -1)

(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.FCMacro\\'" . python-mode))

(tabbar-mode t)
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

;; Workgroups2
(require 'workgroups2)
(workgroups-mode 1)
(setq wg-emacs-exit-save-behavior           'save)      ; Options: 'save 'ask nil
(setq wg-workgroups-mode-exit-save-behavior 'save)      ; Options: 'save 'ask nil

;; === firefox as browser ===
(setq browse-url-browser-function 'browse-url-firefox)

;; === langtool ===
(require 'langtool)
(setq langtool-language-tool-jar "/Software/LanguageTool-3.9/languagetool-commandline.jar")
(setq langtool-default-language "fr")
(global-set-key (kbd "s-g") 'langtool-check)
(global-set-key (kbd "C-s-g") 'langtool-check-done)

;; === Latex  ===
(load "~/.emacs.d/Latex.el")
;; === Org mode ===
(load "~/.emacs.d/momMode.el")
;; === mu4e ===
(load "~/.emacs.d/mu4e.el")
;; === keys ===
(load "~/.emacs.d/keys.el")
;; === sunrine ===
(load "~/.emacs.d/mySunrise.el")
;; === Open with ===
(load "~/.emacs.d/openWith.el")
;; (load "~/.emacs.d/myTheme.el")

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

