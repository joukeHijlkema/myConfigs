(when (string-match-p "134\.212\.[[:digit:]]+\.[[:digit:]]+"
		      (car (split-string (shell-command-to-string (format "ip:%s" "/bin/hostname -I")))))
  (setq url-proxy-services
	'(("no_proxy" . "^\\(localhost\\|10.*\\|vandales-f.onecert.fr\\)")
	  ("http" . "minos.onecert.fr:80")
	  ("https" . "minos.onecert.fr:80"))
	)
  (message "proxies : %s" url-proxy-services)
  )

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 )
      )
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-source-correlate-method (quote ((dvi . source-specials) (pdf . synctex))))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-program-selection
   (quote
    (((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Atril")
     (output-html "xdg-open"))))
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (lab-dark)))
 '(custom-safe-themes
   (quote
    ("980f0adf3421c25edf7b789a046d542e3b45d001735c87057bccb7a411712d09" "a2afb83e8da1d92f83543967fb75a490674a755440d0ce405cf9d9ae008d0018" "392395ee6e6844aec5a76ca4f5c820b97119ddc5290f4e0f58b38c9748181e8d" "13d20048c12826c7ea636fbe513d6f24c0d43709a761052adbca052708798ce3" default)))
 '(dired-omit-files "^\\.+.+\\|^\\.?#\\|^\\.$\\|^\\.\\.$")
 '(doc-view-continuous t)
 '(ecb-options-version "2.50")
 '(ecb-source-path
   (quote
    (("/ssh:pi@lp-rpi-cam3:" "/ssh:pi@lp-rpi-cam3:")
     ("/" "/"))))
 '(ede-project-directories
   (quote
    ("/home/hylkema/Programs/rpiCameras" "/home/hylkema/Programs/Tools/Cedre")))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(ispell-dictionary "fr")
 '(org-agenda-files
   (quote
    ("/home/hylkema/Documents/Org/CNES_RT/2017/CNES_RT_2017.org" "/home/hylkema/Documents/Org/CNES_RT/2018_2019/CNES_RT_2018_2019.org" "/home/hylkema/Documents/Org/ESA/Hydrazine/EsaTrp.org" "/home/hylkema/Documents/Org/journal.org" "/home/hylkema/Documents/Org/Kerc/RG2018.org" "/home/hylkema/Documents/Org/Cours_stages_theses/Theses.org" "/home/hylkema/Documents/Org/Cours_stages_theses/IATOM.org" "/home/hylkema/Documents/Org/Test.org" "/home/hylkema/Documents/Org/Divers/Divers.org" "/home/hylkema/Documents/Org/Divers/CU.org" "/home/hylkema/Documents/Org/Divers/PakOma.org" "/home/hylkema/Documents/Org/Divers/cheatSheet.org" "/home/hylkema/Documents/Org/Divers/SP18.org" "/home/hylkema/Documents/Org/Reviews/AA_2018_170.org" "/home/hylkema/Documents/Org/gtd.org" "/home/hylkema/Documents/Org/Perso/applecross.org" "/home/hylkema/Documents/Org/Perso/changementBanque.org" "/home/hylkema/Documents/Org/Perso/Vlieland.org" "/home/hylkema/Documents/Org/Perso/Toit.org" "/home/hylkema/Documents/Org/Perso/Perso.org" "/home/hylkema/Documents/Org/Perseus/Perseus.org")))
 '(org-icalendar-combined-description "Org mode calendar")
 '(org-icalendar-timezone nil)
 '(org-icalendar-use-deadline (quote (event-if-not-todo event-if-todo todo-due)))
 '(org-icalendar-with-timestamps t)
 '(package-selected-packages
   (quote
    (dired-subtree lab-themes adaptive-wrap neotree treemacs imenu-list org-kanban magit-annex magit-filenotify magit-find-file magit-gerrit magit-gh-pulls magit-gitflow magit-imerge magit-lfs magit-org-todos magit-popup magithub calfw-cal counsel-org-capture-string spacemacs-theme flatui-theme moe-theme org jedi realgud flycheck-gradle gradle-mode elpy sunrise-x-w32-addons mc-extras latex-preview-pane latex-pretty-symbols counsel swiper openwith sunrise-commander sunrise-x-buttons sunrise-x-checkpoints sunrise-x-loop sunrise-x-mirror sunrise-x-modeline sunrise-x-popviewer sunrise-x-tabs sunrise-x-tree org-plus-contrib yasnippet-snippets ac-math auto-complete-auctex langtool calfw-org calfw-ical calfw use-package mu4e-alert mu4e-maildirs-extension mu4e-query-fragments w3m wanderlust org-journal markdown-preview-eww markdown-mode ibuffer-projectile ibuffer-vc projectile-codesearch projectile-git-autofetch projectile-speedbar zephir-mode projectile dh-elpa wsd-mode web-mode virtualenv uncru stify-mode tabbar-ruler sr-speedbar plantuml-mode php+-mode multiple-cursors minimap magit highlight-indentation gnuplot-mode gnuplot flycheck find-file-in-project epc egg ecb direx com pany-irony-c-headers company-irony clang-format auto-install auctex-lua auctex-latexmk)))
 '(quote (cua-mode t nil (cua-base)))
 '(reftex-toc-split-windows-horizontally t)
 '(safe-local-variable-values
   (quote
    ((TeX-command-extra-options . "-shell-escape")
     (eval let nil
	   (save-excursion
	     (org-babel-goto-named-src-block "startblock")
	     (org-babel-execute-src-block))))))
 '(show-paren-mode t)
 '(sr-speedbar-right-side nil)
 '(sr-speedbar-skip-other-window-p t)
 '(tool-bar-mode nil)
 '(virtualenv-root "~hylkema/")
 '(wg-emacs-exit-save-behavior (quote nill))
 '(wg-morph-on nil))

(put 'upcase-region 'disabled nil)

;; (setq ecb-tip-of-the-day nil)
;; (ecb-activate)

;; (minimap-mode)
(put 'downcase-region 'disabled nil)

(load "~/.emacs.d/myInit.el")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mu4e-unread-face ((t (:inherit font-lock-keyword-face :foreground "dark orange" :weight bold)))))
