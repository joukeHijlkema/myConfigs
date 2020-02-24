(use-package org-presentation-mode
  :mode ("\\.orgp\\'" . org-presentation-mode)
  :init
  (message "=== my init org presentation mode ===")
  :custom
  (message "=== my custom org presentation mode ===")
  :config
  (message "=== my config org presentation mode ===")
  :bind (:map org-presentation-mode-map
              ("<s-f12>"	.	opm-runPresentationTool)
              ("<s-h>"          .       opm-help)
              )
)
