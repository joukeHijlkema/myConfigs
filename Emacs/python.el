(add-hook 'python-mode-hook 'jedi:setup)
(elpy-enable)
(setq jedi:complete-on-dot t)                 ; optional
