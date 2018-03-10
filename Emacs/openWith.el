(require 'openwith)
(setq openwith-associations '(
			      ("\\.pdf\\'" "evince" (file))
			      ("\\.\\(?:jp?g\\|png\\)\\'" "eog" (file))
			      ("\\.mp3\\'" "xmms" (file))
			      ("\\.\\(?:mpe?g\\|avi\\|wmv\\)\\'" "mpv" (file)) ))
