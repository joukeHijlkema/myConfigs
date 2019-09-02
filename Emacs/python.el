(use-package python
  :mode
  ("\\.py\\'" . python-mode)
  :init
  (message "== start init python")
  (setq-default indent-tabs-mode nil)
  (setq python-indent-offset 4)
  
  :config
  (message "== start config python")
  (smartparens-mode)
  (color-identifiers-mode)
  (display-line-numbers-mode)
  (message "== end config python")
)

(use-package elpy
  :ensure t
  :commands elpy-enable
  :init (with-eval-after-load 'python (elpy-enable))
  :custom (python-shell-interpreter "python3")
  :config
  (electric-indent-local-mode -1)
  (delete 'elpy-module-highlight-indentation elpy-modules)
  (delete 'elpy-module-flymake elpy-modules)
  
  (defun ha/elpy-goto-definition ()
    (interactive)
    (condition-case err
        (elpy-goto-definition)
      ('error (xref-find-definitions (symbol-name (symbol-at-point))))))


 
  :bind (:map elpy-mode-map ([remap elpy-goto-definition] .
                             ha/elpy-goto-definition))
  )
