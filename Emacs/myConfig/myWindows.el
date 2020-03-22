;;|--------------------------------------------------------------
;;|Description : myGTD layout
;;|NOTE : This is probaly prettier with a loop
;;|-
;;|Author : jouke hylkema
;;|date   : 06-51-2019 13:51:55
;;|--------------------------------------------------------------
(defun myGTDLayout ()
  "myGTD layout"
  (interactive)
  (unless (wg-current-workgroup-p (nth 9 (wg-workgroup-list)))
    (wg-switch-to-workgroup-at-index-9))
  (org-agenda nil " ")
  (delete-other-windows)
  (let ((W (window-width))
        (H (window-height))
        (Big -1)
        (Small -2)
        )
    ;; (message "W=%s,H=%s,R=%s" W H (* W 0.1))
    ;; === inbox ===
    (split-window-right (truncate (* W 0.75)))
    (if (get-buffer "inbox.org")
        (switch-to-buffer "inbox.org")
      (progn
        (find-file "~/Documents/GTD/inbox.org")
        (text-scale-set Big)))
    (org-content)
    ;; === GTD ===
    (split-window-below (truncate (* H 0.20)))
    (windmove-down)
    (if (get-buffer "gtd.org")
        (switch-to-buffer  "gtd.org")
      (progn
        (find-file "~/Documents/GTD/gtd.org")
        (text-scale-set Big)))
    (org-content)
    ;; === Tickler ===
    (split-window-below (truncate (* H 0.6)))
    (windmove-down)
    (if (get-buffer "tickler.org")
        (switch-to-buffer "tickler.org")
      (progn
        (find-file "~/Documents/GTD/tickler.org")
        (text-scale-set Small)))
    (org-content)
    ;; === waiting ===
    (split-window-right (truncate (* W 0.25)))
    (windmove-right)
    (if (get-buffer "waiting.org")
        (switch-to-buffer "waiting.org")
      (progn
        (find-file "~/Documents/GTD/waiting.org")
        (text-scale-set Small)))
    (org-content)
    ;; === maybe once ===
    (split-window-right (truncate (* W 0.25)))
    (windmove-right)
    (if (get-buffer "someday.org")
        (switch-to-buffer "someday.org")
      (progn
        (find-file "~/Documents/GTD/someday.org")
        (text-scale-set Small)))
    (org-content)
    )
  )
;;|--------------------------------------------------------------
;;|Description : layout email
;;|NOTE : 
;;|-
;;|Author : jouke hylkema
;;|date   : 06-51-2019 13:51:22
;;|--------------------------------------------------------------
(defun myEmailLayout ()
  "layout email"
  (interactive)
  (unless (wg-current-workgroup-p (nth 1 (wg-workgroup-list)))
    (wg-switch-to-workgroup-at-index-1))
  (delete-other-windows)
  (cond ((get-buffer "*draft*")
         (set-window-buffer nil "*draft*"))
        ((get-buffer "*Article*")
         (set-window-buffer nil "*Article*"))
        ((get-buffer "*mu4e-view*")
         (set-window-buffer nil "*mu4e-view*"))
        ((get-buffer "*mu4e-headers*")
         (set-window-buffer nil "*mu4e-headers*")
         (mu4e-headers-search-bookmark  "maildir:/Work/INBOX AND flag:unread OR maildir:/Gmail/INBOX AND flag:unread")
         )
        (t
         (mu4e)
         (mu4e-headers-search-bookmark  "maildir:/Work/INBOX AND flag:unread OR maildir:/Gmail/INBOX AND flag:unread")
         )         
        )
  )
;;|--------------------------------------------------------------
;;|Description : move to window number n (from the left)
;;|NOTE : 
;;|-
;;|Author : jouke hylkema
;;|date   : 28-20-2020 16:20:17
;;|--------------------------------------------------------------
(defun myMoveToWindow (n)
  "move to window number n (from the left)"
  (interactive)
  (condition-case nil
      (while t
        (windmove-left))
    (error nil))
  (loop for i
        below n
        do (windmove-right))
  )
;;|--------------------------------------------------------------
;;|Description : layout org
;;|NOTE : 
;;|-
;;|Author : jouke hylkema
;;|date   : 13-05-2020 16:05:11
;;|--------------------------------------------------------------
(defun myOrgLayout ()
  "layout org"
  (interactive)
  (unless (wg-current-workgroup-p (nth 7 (wg-workgroup-list)))
    (wg-switch-to-workgroup-at-index-7))
  (if ( < 1 (count-windows)) (myMoveToWindow 1))
  (let* ((cb (current-buffer))
         (dummy (delete-other-windows))
         (W (window-width))
         (H (window-height))
         (Big -1)
         (Small -2))
    (split-window-right (truncate (* W 0.12)))
    (find-file "~/Documents/Org/Index.org")
    (setq window-size-fixed 'width)
    (windmove-right)
    (split-window-right (truncate (* W 0.7)))
    (switch-to-buffer cb)
    (windmove-right)
    (if (get-buffer "*Org Agenda*")
        (switch-to-buffer "*Org Agenda*")
      )
    (windmove-left)
    )
  )

;;|--------------------------------------------------------------
;;|Description : open a link in the window to the right
;;|NOTE : 
;;|-
;;|Author : jouke hylkema
;;|date   : 13-51-2020 16:51:53
;;|--------------------------------------------------------------
(defun myOpenLink (args)
  "open a link in the window to the right"
  (interactive "P")
  (message "inside open link")
  (message args)
  (windmove-right)
  (find-file args)
  )
