(require 'langtool)
(setq langtool-language-tool-jar "/Software/LanguageTool-4.3/languagetool-commandline.jar")
(setq langtool-language-tool-server-jar "/Software/LanguageTool-4.3/languagetool-server.jar")
(setq langtool-default-language "fr")
(global-set-key (kbd "s-g") 'langtool-check)
(global-set-key (kbd "C-s-g") 'langtool-check-done)

(defun langtool-autoshow-detail-popup (overlays)
  (when (require 'popup nil t)
    ;; Do not interrupt current popup
    (unless (or popup-instances
                ;; suppress popup after type `C-g` .
                (memq last-command '(keyboard-quit)))
      (let ((msg (langtool-details-error-message overlays)))
        (popup-tip msg)))))

(setq langtool-autoshow-message-function
      'langtool-autoshow-detail-popup)
