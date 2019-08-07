(use-package web-mode
  :ensure t
  :init (message "=== my init web-mode ===")
  (defun runPresentationTool ()
    (interactive)
    (let ((default-directory (file-name-directory buffer-file-name)))
      (shell-command (format "~/bin/runPresentationTool %s" (buffer-file-name)))))
  
  :mode (
         ("\\.phtml\\'"           .       web-mode)
         ("\\.tpl\\.php\\'"       .       web-mode)
         ("\\.[agj]sp\\'"         .       web-mode)
         ("\\.as[cp]x\\'"         .       web-mode)
         ("\\.erb\\'"             .       web-mode)
         ("\\.mustache\\'"        .       web-mode)
         ("\\.djhtml\\'"          .       web-mode)
         ("\\.html?\\'"           .       web-mode)
         ("\\.css?\\'"            .       web-mode)
         ("\\.xml?\\'"            .       web-mode)
         ("\\.php\\'"             .       web-mode))
  
  :bind ("<s-f12>"	. runPresentationTool)
)

