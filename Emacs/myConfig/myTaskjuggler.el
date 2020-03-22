(use-package ox-taskjuggler
  :init
  (setq org-taskjuggler-default-global-properties
        "shift s39 \"Full time shift\" {
           workinghours mon-fri 9:00-12:00,13:00-19:00
        }")
  (setq org-duration-units `(("min" . 1)
                             ("h" . 60)
                             ("d" . ,(* 60 8))
                             ("w" . ,(* 60 8 5))
                             ("m" . ,(* 60 8 5 4))
                             ("y" . ,(* 60 8 5 4 10))))
  (org-duration-set-regexps)
  )
