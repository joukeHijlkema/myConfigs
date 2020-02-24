(use-package openwith
  :ensure t
  :init (message "=== my openwith init ===")
  :config
  (setq openwith-associations
	(list
         ;; (list (openwith-make-extension-regexp '("pdf")) "evince" '(file))
         (list (openwith-make-extension-regexp '("flac" "mp3" "wav" "mp4")) "vlc" '(file))
         (list (openwith-make-extension-regexp '("doc" "docx" "odt")) "libreoffice" '("--writer" file))
         (list (openwith-make-extension-regexp '("ods" "xls" "xlsx")) "libreoffice" '("--calc" file))
         (list (openwith-make-extension-regexp '("odp" "pps" "ppt" "pptx")) "libreoffice" '("--impress" file))
         (list (openwith-make-extension-regexp '("vcs")) "/usr/bin/mousepad" '(file))
         ))
  (openwith-mode)
  )


