(use-package eaf
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  :config
  (add-to-list 'load-path "~/.emacs.d/site-lisp/eaf-browser/")
  (require 'eaf-browser)
  (require 'eaf-pdf-viewer)
  (defalias 'browse-web #'eaf-open-browser)
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  ;; (eaf-bind-key take_photo "p" eaf-camera-keybinding)
  (eaf-bind-key nil "M-q" eaf-browser-keybinding)
  (setq eaf-browser-translate-language "es")
  ;; 
  (setq eaf-browser-continue-where-left-off t)
  (setq browse-url-browser-function 'eaf-open-browser)
  (defalias 'browse-web #'eaf-open-browser)
  (setq eaf-browser-enable-adblocker t)
  (setq eaf-browse-blank-page-url "https://baidu.com")

  ) ;; unbind, see more in the Wiki

(provide 'myeaf)
  

