;; === For my own mode(s) ===
(add-to-list 'load-path "~/.emacs.d/myModes/org-presentation")

;; === safe themes ===
(setq custom-safe-themes
   (quote
    ("d14d421ff49120d2c2e0188bcef76008407b3ceff2cfb1d4bdf3684cf3190172" "5e515425f8a5ce00097d707742eb5eee09b27cebc693b8998c734305cbdce1f5" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "980f0adf3421c25edf7b789a046d542e3b45d001735c87057bccb7a411712d09" "a2afb83e8da1d92f83543967fb75a490674a755440d0ce405cf9d9ae008d0018" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
(setq safe-local-variable-values
      (quote (
              (TeX-command-extra-options . "-shell-escape -synctex=1")
              (TeX-command-extra-options . "-shell-escape")
              (eval let nil
                    (save-excursion
                      (org-babel-goto-named-src-block "startblock")
                      (org-babel-execute-src-block)))
              )
             )
      )

;; === flymake bug ===
(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
;; === Windows ===
(load "~/.emacs.d/myConfig/myWindows.el")
;; === Yas ===
(load "~/.emacs.d/myConfig/myYas.el")
;; === Web mode ===
(load "~/.emacs.d/myConfig/myWeb.el")
;; === line numbers off for certain modes ===
(load "~/.emacs.d/myConfig/myLinum-off.el")
;; === langtool ===
(load "~/.emacs.d/myConfig/myLangtool.el")
;; === autoComplete ===
(load "~/.emacs.d/myConfig/myAutoComplete.el")
;; === Latex  ===
(load "~/.emacs.d/myConfig/myPdfTools.el")
(load "~/.emacs.d/myConfig/myLatex.el")
;; === mail ===
(when (string= system-name "LDMPE705H") (load "~/.emacs.d/myConfig/myMu4e.el"))
(when (string= system-name "LDMPE709H") (load "~/.emacs.d/myConfig/myMu4e.el"))
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
;; === Org mode ===
(load "~/.emacs.d/myConfig/myOrg.el")
(load "~/.emacs.d/myConfig/myOrgPresentation.el")
(load "~/.emacs.d/myConfig/myCalDAV.el")
(load "~/.emacs.d/myConfig/myTaskjuggler.el")
;; === Workgroups ===
(load "~/.emacs.d/myConfig/myWg.el")

;; some global stuff
(tool-bar-mode -1)
(setq tramp-default-method "ssh")
(setq browse-url-browser-function 'browse-url-default-browser)

(add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-vc-set-filter-groups-by-vc-root)
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic))))

;; Make missing directories
(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                  (make-directory dir t))))))

(setq set-language-environment "utf-8")
(define-coding-system-alias 'UTF-8 'utf-8)
(set-default-coding-systems 'utf-8)

(setq ecb-tip-of-the-day nil)
(custom-set-variables '(ecb-options-version "2.50"))

(show-paren-mode 1)
(server-start)
