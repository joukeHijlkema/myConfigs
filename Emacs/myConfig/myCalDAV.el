(use-package ido)
(use-package org-caldav
  :init
  :config
  (message "== start config org-caldav")
  (setq org-caldav-url "http://vandales-f.onecert.fr:5232")
  (setq org-icalendar-timezone "Europe/Paris")
  (setq org-caldav-debug-level 2)
  (setq org-caldav-show-sync-results t)
  (setq org-caldav-inbox "/home/hylkema/Documents/Org/Calendar/org-caldav.inbox")
  (setq org-caldav-sync-direction 'org->cal)

  ;;|--------------------------------------------------------------
  ;;|Description : create event and sync it withe the right calendar
  ;;|NOTE : 
  ;;|-
  ;;|Author : jouke hylkema
  ;;|date   : 08-09-2019 10:09:08
  ;;|--------------------------------------------------------------
  (defun myCalDavSave ()
    "create event and sync it withe the right calendar"
    (if (or org-note-abort (not (equal myOrg-capture-type "event")))
        (message "capture aborted or not an event")
      (let ((fn (buffer-file-name (plist-get org-capture-plist :buffer))))
        (progn
          (cond ((equal  fn "/home/hylkema/Documents/Org/Calendar/Absences.org")
                 (setq org-caldav-inbox "/home/hylkema/Documents/Org/Calendar/Absences.inbox")
                 (setq org-caldav-calendar-id "LP/Absences"))
                ((equal  fn "/home/hylkema/Documents/Org/Calendar/Deplacements.org")
                 (setq org-caldav-inbox "/home/hylkema/Documents/Org/Calendar/Deplacements.inbox")
                 (setq org-caldav-calendar-id "LP/Deplacements"))
                ((equal  fn "/home/hylkema/Documents/Org/Calendar/Essais.org")
                 (setq org-caldav-inbox "/home/hylkema/Documents/Org/Calendar/Essais.inbox")
                 (setq org-caldav-calendar-id "LP/Essais"))
                ((equal  fn "/home/hylkema/Documents/Org/Calendar/Divers.org")
                 (setq org-caldav-inbox "/home/hylkema/Documents/Org/Calendar/Divers.inbox")
                 (setq org-caldav-calendar-id "LP/Divers"))
                ((equal  fn "/home/hylkema/Documents/Org/Calendar/Reunions.org")
                 (setq org-caldav-inbox "/home/hylkema/Documents/Org/Calendar/Reunions.inbox")
                 (setq org-caldav-calendar-id "LP/Reunions"))
                )
          (setq org-caldav-files (list fn))
          (org-caldav-sync)
          )
        )
      (setq org-caldav-inbox "/home/hylkema/Documents/Org/Calendar/org-caldav.inbox")
      )
    )
  )


