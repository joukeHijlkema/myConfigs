(use-package mu4e
  :load-path "/usr/local/share/emacs/site-lisp/mu4e"
  :commands mu4e
  :init (message "=== my mu4e init ===")
  (defun etc/imapfilter ()
    (message "Running imapfilter...")
    (with-current-buffer (get-buffer-create " *imapfilter*")
      (goto-char (point-max))
      (insert "---\n")
      (call-process "imapfilter" nil (current-buffer) nil "-v"))
    (message "Running imapfilter...done"))

  (defun joukeAddTag ()
    (interactive)
    (let
        (myTag (read-string "What tag do you want to add?"))
      (mu4e-action-retag-message (mu4e-message-at-point) myTag)
      )
    )

  (defun compose-attach-marked-files ()
    "Compose mail and attach all the marked files from a dired buffer."
    (interactive)
    (let ((files (dired-get-marked-files)))
      (compose-mail nil nil nil t)
      (dolist (file files)
        (if (file-regular-p file)
            (mml-attach-file file
                             (mm-default-file-encoding file)
                             nil "attachment")
          (message "skipping non-regular file %s" file)))))

  ;; === spam filter ===
  (defun mark-message-as (msg type) 
    (let* ((path (mu4e-message-field msg :path)) 
           (command (format "/usr/bin/bogofilter %s < %s" type path))) 
      (shell-command command)))

  (defun mark-message-as-spam (msg docid) 
    (interactive)
    (mark-message-as msg "-s")
    (mu4e~proc-move docid "/Spam" "+S-N")
    )

  (defun mark-message-as-ham  (msg docid) 
    (interactive) 
    (mark-message-as msg "-n")
    (mu4e~proc-move docid "/Work/INBOX" "+S-N"))


  (defun muTest ()
    (interactive)
    (setq myTmp (mu4e-message-field-at-point :path)))
  
  (defun gnus-dired-mail-buffers ()
    "Return a list of active message buffers."
    (let (buffers)
      (save-current-buffer
        (dolist (buffer (buffer-list t))
          (set-buffer buffer)
          (when (and (derived-mode-p 'message-mode)
                     (null message-sent-message-via))
            (push (buffer-name buffer) buffers))))
      (nreverse buffers)))

  :config
  (setq mu4e-installation-path "/usr/local/share/emacs/site-lisp/mu4e")
  (add-to-list  'mm-inhibit-file-name-handlers 'openwith-file-handler)
  (setq mu4e-get-mail-command "offlineimap -o")
  (setq mu4e-headers-fields
        (quote
         ((:human-date . 12)
          (:flags . 6)
          (:mailing-list . 10)
          (:from . 22)
          (:to . 22)
          (:subject))))
  (setq mu4e-headers-visible-lines 25)
  (setq mu4e-maildir "/home/hylkema/Maildir")
  (setq mu4e-split-view (quote single-window))
  (setq mu4e-update-interval 300)
  (setq mu4e-use-fancy-chars t)
  (setq mu4e-user-mail-address-list (quote ("jouke.hijlkema@onera.fr")))
  (setq mu4e-view-prefer-html nil)
  (setq mu4e-view-show-addresses nil)
  (setq mu4e-view-show-images nil)
  (mu4e~headers-defun-mark-for spam)
  (mu4e~view-defun-mark-for spam)
  (mu4e~headers-defun-mark-for ham)
  (mu4e~view-defun-mark-for ham)
  ;; enable inline images
  (setq mu4e-view-show-images t)
  ;; use imagemagick, if available
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))
  (setq mu4e-headers-show-threads nil)
  (setq mu4e-bookmarks
        (list
         (make-mu4e-bookmark
          :name "Inbox"
          :query "maildir:/Work/INBOX NOT flag:trashed "
          :key ?i)))
  (add-to-list 'mu4e-bookmarks
               (make-mu4e-bookmark
                :name "Inbox unread"
                :query "maildir:/Work/INBOX AND flag:unread OR maildir:/Gmail/INBOX AND flag:unread"
                :key ?u))
  (add-to-list 'mu4e-bookmarks
               (make-mu4e-bookmark
                :name "Sent"
                :query "maildir:/sent OR maildir:/Work/sent"
                :key ?s))
  (add-to-list 'mu4e-bookmarks
               (make-mu4e-bookmark
                :name "Today"
                :query "maildir:/Work/INBOX AND date:today..now AND NOT flag:trashed"
                :key ?t))
  (add-to-list 'mu4e-bookmarks
               (make-mu4e-bookmark
                :name "Last week"
                :query "maildir:/Work/INBOX AND date:1w..now AND NOT flag:trashed"
                :key ?w))
  (add-to-list 'mu4e-bookmarks
               (make-mu4e-bookmark
                :name "Last month"
                :query "maildir:/Work/INBOX AND date:5w..now AND NOT flag:trashed"
                :key ?m))
  (add-to-list 'mu4e-bookmarks
               (make-mu4e-bookmark
                :name "Spam"
                :query "maildir:/Spam AND flag:unread"
                :key ?z))
  (add-to-list 'mu4e-bookmarks
               (make-mu4e-bookmark
                :name "Gmail all"
                :query "maildir:/Gmail/INBOX"
                :key ?g))
  (mu4e-alert-set-default-style 'libnotify)
  (setq mu4e-alert-interesting-mail-query
        (concat
         "flag:unread"
         " AND NOT flag:trashed"
         " AND maildir:\"/Work/INBOX\""
         ))

  (setq mu4e-headers-visible-lines 15)
  
  ;; === Tagging ===
  (add-to-list 'mu4e-marks
               '(spam
                 :char       "s"
                 :prompt     "spam"
                 :show-target (lambda (target) "spam")
                 :action      (lambda (docid msg target)
                                (mark-message-as-spam msg docid)
                                )
                 )
               )
  (add-to-list 'mu4e-marks
               '(ham
                 :char       "h"
                 :prompt     "ham"
                 :show-target (lambda (target) "ham")
                 :action      (lambda (docid msg target)
                                (mark-message-as-ham msg docid)
                                )
                 )
               )
  (add-to-list 'mu4e-marks
               '(tag
                 :char       "r"
                 :prompt     "rapportTag"
                 :ask-target (lambda () (read-string "What tag do you want to add?"))
                 :action      (lambda (docid msg target)
                                (mu4e-action-retag-message msg (concat "+" target)))))
  ;; === send mail ===
  ;; tell message-mode how to send mail
  (setq message-send-mail-function 'smtpmail-send-it)
  (setq smtpmail-smtp-server "imap-mip.onecert.fr")

  ;; === compose ===
  (add-hook 'mu4e-compose-mode-hook
  (defun my-do-compose-stuff ()
    "My settings for message composition."
    (set-fill-column 180)
    (flyspell-mode)))

  ;; make the `gnus-dired-mail-buffers' function also work on
  ;; message-mode derived modes, such as mu4e-compose-mode
  (setq gnus-dired-mail-mode 'mu4e-user-agent)
  (add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

  ;; === Filtering ===
  (add-hook 'mu4e-update-pre-hook 'etc/imapfilter)

  ;; === To work with Gmail ===
  (setq mu4e-contexts
        `( ,(make-mu4e-context
             :name "Gmail"
             :match-func (lambda (msg) (when msg
                                         (string-prefix-p "/Gmail" (mu4e-message-field msg :maildir))))
             :vars '(
                     (mu4e-trash-folder . "/Gmail/[Gmail].Trash")
                     (mu4e-refile-folder . "/Gmail/[Gmail].Archive")
                     ))
           ,(make-mu4e-context
             :name "Work"
             :match-func (lambda (msg) (when msg
                                         (string-prefix-p "/Work" (mu4e-message-field msg :maildir))))
             :vars '(
                     (mu4e-trash-folder . "/Work/INBOX.Trash")
                     (mu4e-refile-folder . exchange-mu4e-refile-folder)
                     ))
           ))

  ;; === signatuere ===

  (setq mu4e-compose-signature "
========================================================================
| Jouke Hijlkema
| Ingénieur de recherche
| DMPE/LPF
| tel: +33 5 61 56 63 93 / +33 6 37 32 60 82
| ONERA - The French Aerospace Lab - Centre du Fauga Mauzac
| 31410 Mauzac
| Nous suivre sur : http://www.onera.fr 
|                   http://www.twitter.com/@onera_fr
|                   http://www.linkedin.com/company/onera
|                   http://www.facebook.fr/thefrenchaerospacelab
| Avertissement/disclaimer http://www.onera.fr/onera-en/emails-terms
========================================================================")

  :bind (
  (:map mu4e-view-mode-map ("s-s" . mu4e-view-mark-for-spam))
  (:map mu4e-view-mode-map ("s-h" . mu4e-view-mark-for-ham))
  (:map mu4e-view-mode-map ("f" . joukeAddTag))
  (:map mu4e-headers-mode-map ("s-s" . mu4e-headers-mark-for-spam))
  (:map mu4e-headers-mode-map ("s-h" . u4e-headers-mark-for-ham))
  (:map mu4e-headers-mode-map ("f" . joukeAddTag))
  (:map mu4e-compose-mode-map ("<s-delete>" . mu4e-message-kill-buffer))
  )

  :hook (
         mu4e-alert-enable-notifications
         mu4e-alert-enable-mode-line-display
         )

)





