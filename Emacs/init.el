(when (or (string= system-name "CFM-WDMAE007H") (string= system-name "batave-f"))
  (setq url-proxy-services
	'(("no_proxy" . "^\\(localhost\\|10.*\\|vandales-f.onecert.fr\\)")
	  ("http" . "minos.onecert.fr:80")
	  ("https" . "minos.onecert.fr:80"))))

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")
			 ("SC"   . "http://joseito.republika.pl/sunrise-commander/")
			 )
      )
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-start t)
 '(ac-modes
   (quote
    (latex-mode emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode nim-mode c-mode cc-mode c++-mode objc-mode swift-mode go-mode java-mode malabar-mode clojure-mode clojurescript-mode scala-mode scheme-mode ocaml-mode tuareg-mode coq-mode haskell-mode agda-mode agda2-mode perl-mode cperl-mode python-mode ruby-mode lua-mode tcl-mode ecmascript-mode javascript-mode js-mode js-jsx-mode js2-mode js2-jsx-mode coffee-mode php-mode css-mode scss-mode less-css-mode elixir-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode web-mode ts-mode sclang-mode verilog-mode qml-mode apples-mode)))
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (tango-dark)))
 '(dired-omit-files "^\\.+.+\\|^\\.?#\\|^\\.$\\|^\\.\\.$")
 '(ede-project-directories (quote ("/home/hylkema/Programs/Tools/Cedre")))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(ispell-dictionary "fr")
 '(minimap-mode nil)
 '(minimap-window-location (quote left))
 '(mu4e-get-mail-command "offlineimap -o")
 '(mu4e-headers-fields
   (quote
    ((:human-date . 12)
     (:flags . 6)
     (:mailing-list . 10)
     (:from . 22)
     (:to . 22)
     (:subject))))
 '(mu4e-headers-visible-lines 25)
 '(mu4e-maildir "/home/hylkema/Maildir")
 '(mu4e-split-view nil)
 '(mu4e-update-interval 300)
 '(mu4e-use-fancy-chars t)
 '(mu4e-user-mail-address-list (quote ("jouke.hijlkema@onera.fr")))
 '(mu4e-view-prefer-html nil)
 '(mu4e-view-show-addresses nil)
 '(mu4e-view-show-images nil)
 '(org-agenda-file-regexp "^[^#]*\\.org$")
 '(org-agenda-files
   (quote
    ("/home/hylkema/Documents/Org/Divers.org" "/home/hylkema/Documents/Org/Perseus.org" "/home/hylkema/Documents/Org/Test.org" "/home/hylkema/Documents/Org/cheatSheet.org")))
 '(org-agenda-skip-scheduled-if-done t)
 '(org-babel-load-languages (quote ((emacs-lisp . t) (shell . t))))
 '(org-file-apps
   (quote
    ((auto-mode . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . default)
     ("\\.pdf\\'" . "/usr/bin/masterpdfeditor4"))))
 '(org-log-done (quote note))
 '(org-support-shift-select t)
 '(package-selected-packages
   (quote
    (counsel swiper openwith sunrise-commander sunrise-x-buttons sunrise-x-checkpoints sunrise-x-loop sunrise-x-mirror sunrise-x-modeline sunrise-x-popviewer sunrise-x-tabs sunrise-x-tree org-plus-contrib yasnippet-snippets ac-math auto-complete-auctex langtool calfw-org calfw-ical calfw use-package mu4e-alert mu4e-maildirs-extension mu4e-query-fragments w3m wanderlust org-journal markdown-preview-eww markdown-mode ibuffer-projectile ibuffer-vc projectile-codesearch projectile-git-autofetch projectile-speedbar zephir-mode projectile dh-elpa wsd-mode web-mode virtualenv uncru stify-mode tabbar-ruler sr-speedbar pyvenv python-environment plantuml-mode php+-mode multiple-cursors minimap magit highlight-indentation gnuplot-mode gnuplot flycheck find-file-in-project epc egg ecb direx com pany-irony-c-headers company-irony clang-format auto-install auctex-lua auctex-latexmk)))
 '(reftex-toc-split-windows-horizontally t)
 '(show-paren-mode t)
 '(speedbar-sort-tags t)
 '(speedbar-tag-hierarchy-method
   (quote
    (speedbar-prefix-group-tag-hierarchy speedbar-trim-words-tag-hierarchy speedbar-sort-tag-hierarchy)))
 '(tool-bar-mode nil)
 '(virtualenv-root "~hylkema/")
 '(wg-morph-on nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 101 :width normal))))
 '(ecb-tag-header-face ((t (:background "light salmon"))))
 '(org-agenda-date ((t (:foreground "#c4a06c" :weight bold :height 1.1))))
 '(org-agenda-date-weekend ((t (:foreground "#81a05b" :weight bold :height 1.1))))
 '(tabbar-default ((t (:background "#282c34" :foreground "gray" :height 1.0))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "dark slate gray" :foreground "green yellow" :weight bold))))
 '(tabbar-unselected ((t (:inherit tabbar-default :foreground "medium aquamarine")))))
(put 'upcase-region 'disabled nil)

;; (setq ecb-tip-of-the-day nil)
;; (ecb-activate)

;; (minimap-mode)
(put 'downcase-region 'disabled nil)

(load "~/.emacs.d/myInit.el")

