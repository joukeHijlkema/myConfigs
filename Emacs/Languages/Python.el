(defun my_python_new (name)
  "create a new file named name"
  (interactive "BFile name :")     ; ask for a buffer name
  (switch-to-buffer-other-window (concat name ".py"))
  (erase-buffer)
  (insert "#!/usr/bin/env python\n")
  (insert "# -*- coding: utf-8 -*-\n")
  (insert "#\n")
  (insert "#  =================================================\n")
  (insert (concat "# " name "\n"))
  (insert "#   - Author jouke hijlkema <jouke.hijlkema@onera.fr>\n")
  (insert (concat "#   - " (current-time-string) "\n"))
  (insert "#   - Initial Version 1.0\n")
  (insert "#  =================================================\n")
)

