;;; package --- Summary
;;; Commentary:
;;; Code:
;; the basic configuration about the elisp
(add-hook 'emacs-lisp-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'emacs-lisp-mode-hook 'lispy-mode)
(add-hook 'emacs-lisp-mode-hook 'menu-bar-mode)

(provide 'myelisp)
;;; myelisp.el ends here
