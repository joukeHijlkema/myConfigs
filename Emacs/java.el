(use-package jdee
  :mode
  ("\\.java\\'" . jdee-mode):config
  (progn
    (setq jdee-server-dir "/Software/jdee-server/target")
    (defun uncrustify-get-lang-from-mode (&optional mode)
      "uncrustify lang option"
      (let ((m (or mode major-mode)))
	(case m
	  ('c-mode "C")
	  ('c++-mode "CPP")
	  ('d-mode "D")
	  ('java-mode "JAVA")
	  ('jdee-mode "JAVA")
	  ('objc-mode "OC")
	  ('python-mode "PYTHON")
	  (t
	   nil))))
    )
)
