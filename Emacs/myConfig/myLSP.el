(use-package lsp-mode
  :init (setq lsp-keymap-prefix "s-l")
  :commands lsp
  :config
  (message "=== myLSP init start")
  :bind (:map lsp-mode-map
              ("<mouse-3>" . nil)
              ("<C-down-mouse-1>" . nil)
              )
  )


;; ;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-treemacs
  :commands lsp-treemacs-symbols)
 
