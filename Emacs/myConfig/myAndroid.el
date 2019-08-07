(use-package hydra
  :ensure t)
(use-package android-env
  :ensure t
  :after hydra
  :config
  (message "=== android-env config ===")
  (setq android-env-executable "./gradlew")
  (setq android-env-test-command "connectedDevDebugAndroidTest")
  (setq android-env-unit-test-command "testDevDebug")
  (android-env)
  :bind (("C-c a" . hydra-android/body))
  )
  
