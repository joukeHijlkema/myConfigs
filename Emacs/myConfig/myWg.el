(use-package workgroups2
  :ensure t
  :init (message "=== my wg init ===")
  (workgroups-mode)
                 
  :config
  (setq wg-emacs-exit-save-behavior           'save)
  (setq wg-workgroups-mode-exit-save-behavior 'save)
  :bind (
         ("s-<kp-0>" . wg-switch-to-workgroup-at-index-0)
         ("s-<kp-1>" . wg-switch-to-workgroup-at-index-1)
         ("s-<kp-2>" . wg-switch-to-workgroup-at-index-2)
         ("s-<kp-3>" . wg-switch-to-workgroup-at-index-3)
         ("s-<kp-4>" . wg-switch-to-workgroup-at-index-4)
         ("s-<kp-5>" . wg-switch-to-workgroup-at-index-5)
         ("s-<kp-6>" . wg-switch-to-workgroup-at-index-6)
         ("s-<kp-7>" . wg-switch-to-workgroup-at-index-7)
         ("s-<kp-8>" . wg-switch-to-workgroup-at-index-8)
         ("s-<kp-9>" . jouke-switch-to-cal)
         ("s-0" . wg-switch-to-workgroup-at-index-0)
         ("s-1" . wg-switch-to-workgroup-at-index-1)
         ("s-2" . wg-switch-to-workgroup-at-index-2)
         ("s-3" . wg-switch-to-workgroup-at-index-3)
         ("s-4" . wg-switch-to-workgroup-at-index-4)
         ("s-5" . wg-switch-to-workgroup-at-index-5)
         ("s-6" . wg-switch-to-workgroup-at-index-6)
         ("s-7" . wg-switch-to-workgroup-at-index-7)
         ("s-8" . wg-switch-to-workgroup-at-index-8)
         ("s-9" . wg-switch-to-workgroup-at-index-9)
         ("<s-kp-divide>" . delete-other-windows)
         ("<s-kp-multiply>" . wg-revert-workgroup)
         ("<s-kp-subtract>" . wg-save-session)
         )
  )

  
