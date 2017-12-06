(require 'calfw)
(require 'calfw-ical)
(require 'calfw-cal)
(require 'calfw-org)

(setq org-caldav-calendars
      '((:calendar-id "Reunions"
		      :url "http://vandales-f.onecert.fr:5232/LP"
		      :inbox       "~/org/lpReunions.org"
		      :files       ("~/org"))
))

(defun my-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-file-source "Reunions" "~/org/lpReunions.org" "Orange") 
    (cfw:ical-create-source "google Jouke" "https://calendar.google.com/calendar/ical/rna08vpcfhb8q6fd9p0vm4fcmc%40group.calendar.google.com/private-4619b33f868a102c27a7028572710acb/basic.ics" "Orange")
    (cfw:ical-create-source "google Vero" "https://calendar.google.com/calendar/ical/timbert.veronique%40gmail.com/public/basic.ics" "IndianRed")
   )))
