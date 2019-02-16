(require 'notmuch)
(setq notmuch-search-oldest-first nil)
(setq message-kill-buffer-on-exit t)
(setq notmuch-fcc-dirs nil)
 
;; === send mail ===
;; tell message-mode how to send mail
(setq message-send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server "imap-mip.onecert.fr")

;; Define Identities
(setq gnus-alias-identity-alist
      '(("work"
         nil ;; Does not refer to any other identity
         "Jouke Hijlkema <jouke.hijlkema@onera.fr" ;; Sender address
         nil ;; No organization header
         nil ;; No extra headers
         nil ;; No extra body text
         "~/.signature"
         )))

;; Use "work" identity by default
(setq gnus-alias-default-identity "work")

(add-hook 'notmuch-message-mode-hook
  (defun my-do-compose-stuff ()
    "My settings for message composition."
    (set-fill-column 180)
    (flyspell-mode)))

;; === shortcuts ===

(defun my-nm-action (action data)
  (message "action = %s" action)
  (message "data   = %s" data))

(define-key notmuch-search-mode-map (kbd "s-j") (my-nm-action "Junk" "data"))

(define-key notmuch-search-mode-map "d"
      (lambda ()
        "toggle deleted tag for message"
        (interactive)
        (if (member "deleted" (notmuch-search-get-tags))
            (notmuch-search-tag (list "-deleted"))
          (notmuch-search-tag (list "+deleted")))))
(define-key notmuch-show-mode-map "d"
      (lambda ()
        "toggle deleted tag for message"
        (interactive)
        (if (member "deleted" (notmuch-show-get-tags))
            (notmuch-show-tag (list "-deleted"))
          (notmuch-show-tag (list "+deleted")))))


