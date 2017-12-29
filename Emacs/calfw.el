(require 'calfw)
(require 'calfw-org)
(require 'calfw-ical)


(cfw:open-calendar-buffer
 :contents-sources
   (list 
     (cfw:ical-create-source "essais" "http://vandales-f.onecert.fr:5232/LP/Essais" "red")
     (cfw:ical-create-source "absences" "http://vandales-f.onecert.fr:5232/LP/Absences" "darkgreen")
     (cfw:ical-create-source "depl." "http://vandales-f.onecert.fr:5232/LP/Deplacements" "white")
     (cfw:ical-create-source "reunions" "http://vandales-f.onecert.fr:5232/LP/Reunions" "orange")
     (cfw:ical-create-source "divers" "http://vandales-f.onecert.fr:5232/LP/Divers" "lightblue")
     )
)
