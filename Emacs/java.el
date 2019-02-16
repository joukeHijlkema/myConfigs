(require 'gradle-mode)
(add-hook 'java-mode-hook '(lambda() (gradle-mode 1)))
