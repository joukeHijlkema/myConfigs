(use-package langtool
  :ensure t
  :init
 (defun langtool-autoshow-detail-popup (overlays)
  (when (require 'popup nil t)
    ;; Do not interrupt current popup
    (unless (or popup-instances
                ;; suppress popup after type `C-g` .
                (memq last-command '(keyboard-quit)))
      (let ((msg (langtool-details-error-message overlays)))
        (popup-tip msg)))))
 
  :config
  (setq langtool-language-tool-jar "/Software/LanguageTool-4.7/languagetool-commandline.jar")
  (setq langtool-language-tool-server-jar "/Software/LanguageTool-4.7/languagetool-server.jar")
  (setq langtool-default-language "fr")
  (setq langtool-autoshow-message-function 'langtool-autoshow-detail-popup)

  :bind (
         ("s-g" . langtool-check)
         ("C-s-g" . langtool-check-done)
         )

)
