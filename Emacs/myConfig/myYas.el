(use-package yasnippet 
  :ensure t
  :init (message "=== my init yas-mode ===")
  :config
  (yas-global-mode)
  :bind
  ("s-n" . yas-next-field)
  )
