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
   'align-load-hook
   (lambda ()
     (message "== align hook for python")
     (mapcar
      (lambda (i)
        (if (equal (car i) 'python-assignment)
            (setcdr i '((regexp . "\\(\\s-*\\)[\\+-\\*\\\\]?=")
                      (mode . python-mode)
                      (justify . t))
                    )
          )
        ) align-rules-list)))
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
  (setq elpy-default-minor-modes '(elpy-module-sane-defaults
                                   elpy-module-company
                                   elpy-module-eldoc
                                   elpy-module-pyvenv
                                   elpy-module-yasnippet
                                   elpy-module-django))
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
