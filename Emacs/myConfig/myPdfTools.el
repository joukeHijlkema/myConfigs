(use-package pdf-tools
 :init
 (message "== start init pdf-tools")
 (pdf-tools-install)
 (setq-default pdf-view-display-size 'fit-page)
 (setq pdf-annot-activate-created-annotations t)
 (setq pdf-misc-print-programm "/usr/bin/lpr")
 (setq pdf-misc-print-programm-args (quote ("-o media=a4" "-o fitplot")))
 (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
 (auto-revert-mode)
 (setq revert-without-query '(".*.pdf"))
 
 (add-hook 'pdf-annot-modified-functions 'myPdf-annotate-done)
   
 ;;|--------------------------------------------------------------
 ;;|Description : annotate pdf and copy text to left window
 ;;|NOTE : 
 ;;|-
 ;;|Author : jouke hylkema
 ;;|date   : 15-59-2019 09:59:14
 ;;|--------------------------------------------------------------
 (defun myPdf-annotate ()
   "annotate pdf and copy text to left window"
   (interactive)
   (let* ((edges (pdf-view-active-region))
          (ann (pdf-annot-add-annotation 'highlight edges `(("color" . "#ffff00"))))
          )
     )
   )
 ;;|--------------------------------------------------------------
 ;;|Description : annotation finished
 ;;|NOTE : 
 ;;|-
 ;;|Author : jouke hylkema
 ;;|date   : 15-02-2019 13:02:29
 ;;|--------------------------------------------------------------
 (defun myPdf-annotate-done (&optional ann)
   "annotation finished"
   (save-excursion
     (cond
      ((funcall ann :inserted)
       (message (format "inserted %s" (nth 0 (funcall ann :inserted))))
       (myPdf-annotation-inserted (nth 0 (funcall ann :inserted)))
       )
      ((funcall ann :changed)
       (message (format "changed %s" (nth 0 (funcall ann :changed))))
       (myPdf-annotation-changed (nth 0 (funcall ann :changed)))
       )
      ((funcall ann :deleted)
       (message (format "deleted %s" (nth 0 (funcall ann :deleted))))
       (myPdf-annotation-deleted (nth 0 (funcall ann :deleted)))
       )
      )
     )
   )
 ;;|--------------------------------------------------------------
 ;;|Description : Annotation inserted
 ;;|NOTE : 
 ;;|-
 ;;|Author : jouke hylkema
 ;;|date   : 15-47-2019 14:47:51
 ;;|--------------------------------------------------------------
 (defun myPdf-annotation-inserted (ann)
   "Annotation inserted"
   (message "Annotation inserted")
   (windmove-left 1)
   (let ((id (pdf-annot-get ann 'id))
         (txt (pdf-annot-get ann 'contents))
         (docId (org-entry-get (point) "ID" t))
         (end (if (org-element-property :contents-end (org-element-at-point))
                  (org-element-property :contents-end (org-element-at-point))
                (org-element-property :end (org-element-at-point))
                )
              )
         (parent (org-element-property :parent (org-element-at-point)))
         )
     (org-id-goto docId)
     (search-forward "Notes")
     (beginning-of-line)
     (org-insert-subheading "note")
     (org-edit-headline (format "%s:%s" docId id))
     )
   (windmove-right 1)
   )
 ;;|--------------------------------------------------------------
 ;;|Description : Annotation changed
 ;;|NOTE : Jump to the annotation and modify its contents
 ;;|-
 ;;|Author : jouke hylkema
 ;;|date   : 15-07-2019 15:07:12
 ;;|--------------------------------------------------------------
 (defun myPdf-annotation-changed (ann)
   "Annotation changed"
   (windmove-left 1)
   (let* ((docId (org-entry-get (point) "ID" t))
         (id (format "%s:%s" docId (pdf-annot-get ann 'id)))
         (txt (format "%s" (pdf-annot-get ann 'contents)))
         )
     (org-map-entries
      (lambda ()
        (if (equal id (org-entry-get (point) "ITEM"))
            (progn
              (when (org-element-property :contents-begin (org-element-at-point))
                (delete-region (org-element-property :contents-begin (org-element-at-point))
                               (org-element-property :contents-end (org-element-at-point))))
              (message "%s" (org-element-at-point))
              (goto-char (org-element-property :end (org-element-at-point)))
              (insert (format "%s\n" txt))
              )
          )
        ) nil 'file)
     )
   (windmove-right 1)
   (save-buffer)
   )
 ;;|--------------------------------------------------------------
 ;;|Description : Annotation deleted
 ;;|NOTE : 
 ;;|-
 ;;|Author : jouke hylkema
 ;;|date   : 15-43-2019 16:43:25
 ;;|--------------------------------------------------------------
 (defun myPdf-annotation-deleted (ann)
   "Annotation deleted"
   (windmove-left 1)
   (let* ((docId (org-entry-get (point) "ID" t))
          (id (format "%s:%s" docId (pdf-annot-get ann 'id)))
          )
     (org-map-entries
      (lambda ()
        (if (equal id (org-entry-get (point) "ITEM"))
            (progn
              (org-mark-subtree)
              (delete-region (region-beginning) (region-end))
              ))
        ) nil 'file)
     (windmove-right 1)
     )
   )
 (add-hook 'pdf-annot-edit-contents-minor '(myPdf-annotate-done "edit"))
 
 (message "== end init pdf-tools")
 :hook ((pdf-view-mode . (lambda ()
                    (message "== pdf view mode hook ==")
                    (auto-revert-mode)
                    ))
        )


 :bind ((:map pdf-view-mode-map
              ("s-a" . myPdf-annotate)
              ))
 )
