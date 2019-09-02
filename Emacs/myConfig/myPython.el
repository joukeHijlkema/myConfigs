(use-package python
  :ensure t
  :mode
  ("\\.py\\'" . python-mode)
  :init
  (message "== my init python")
  (setq-default indent-tabs-mode nil)
  
  :config
  (message "== start config python")
  (setq python-indent-offset 4)
  (add-hook
   'align-load-hook (lambda ()
		       (message "== align hook for python")
  		       (add-to-list
  			'align-rules-list
  			'(python-assignment
  			  (regexp . "\\(\\s-*\\)\\+=")
  			  (mode . '(python-mode))
  			  (repeat . nil)))))
  (add-hook 'python-mode-hook (lambda ()
                           (message "== python hook for python")
                           (smartparens-mode)
                           (color-identifiers-mode)
                           (linum-mode t)
                           ))
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
