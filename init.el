(setq use-package-always-ensure t)
(require 'package)
(package-initialize)
(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/") t)
;; 添加额外的路径
(add-to-list 'load-path "~/.emacs.d/Initfiles/")
(setq inhibit-startup-screen t)

(if (display-graphic-p)
    (setq initial-frame-alist
          '(
            (tool-bar-lines . 0)
            ;; (width . 86)
            ;; (height . 55)
            (fullscreen . maximized)
            ))
  (setq initial-frame-alist '((tool-bar-lines . 0))))
;; highlight brackets
(setq default-frame-alist
      '(
        (tool-bar-lines . 0)
        ;; (width . 80)
        ;; (height . 55)
        (fullscreen . maximized)))
(setq-default frame-title-format '("sayno"))
(column-number-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; backup and file related
;; whether generate the file~
(setq make-backup-files nil)
(setq backup-by-copying t)
(setq create-lockfiles nil)
(setq auto-save-default t)
(setq-default indent-tabs-mode t)
;; 4 is more popular than 8.
(setq-default tab-width 4)
;; about the cursor
(setq-default cursor-type 'bar)
;; blink the cursor
(blink-cursor-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-frame-font "DejaVu Sans Mono" t t)

;; set Enter to function 'newline-and-indent, it is useful.
(define-key global-map (kbd "RET" ) 'newline-and-indent)
(set-default 'tab-always-indent 'complete)
;; no mixed tab space


;;
(scroll-bar-mode -1)
(tool-bar-mode -1)
;; menu-bar-mode is useful
(menu-bar-mode 1)

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)



;; add "open recent" in your "File" in your menu.
(require 'recentf)
(recentf-mode 1)

;; highlight the paren
(show-paren-mode 1)
;; delete in pair
(electric-pair-mode 1)
(global-auto-revert-mode 1)

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'LaTeX-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'progn-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'markdown-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'org-mode-hook 'rainbow-delimiters-mode))
;; file directory structure
(use-package neotree
  :ensure t
  :init
  (bind-key "<f8>" 'neotree-toggle))

;; check the syntax
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*Flycheck errors*" eos)
                 (display-buffer-reuse-window
                  display-buffer-in-side-window)
                 (side            . bottom)
                 (reusable-frames . visible)
                 (window-height   . 0.33))))

(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))

;; if display column-number in mode line

;; use for change to the minibuffer
(defun switch-to-minibuffer ()
  "Switch to minibuffer window."
  (interactive)
  (if (active-minibuffer-window)
      (select-window (active-minibuffer-window))
    (error "Minibuffer is not active")))
(global-set-key "\C-co" 'switch-to-minibuffer) ;; Bind to `C-c o'

;; can change the alpha
(set-frame-parameter (selected-frame) 'alpha '(100 . 100))
(add-to-list 'default-frame-alist '(alpha . (100 . 100)))
(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
    nil 'alpha
    (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
        '(85 . 50) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)
;; open the 'ido-mode
(require 'ido)
(ido-mode 1)
(setf (nth 2 ido-decorations) "\n")
(require 'icomplete)
(icomplete-mode 1)
(setq icomplete-separator "\n")
(setq icomplete-hide-common-prefix nil)
(setq icomplete-in-buffer t)

;;; my basic config



(require 'mylatex)
(require 'mymarkdown)
(require 'myelisp)
(require 'mymagit)
(require 'myorg)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" default))
 '(package-selected-packages
   '(use-package solarized-theme rainbow-delimiters pdf-tools neotree markdown-preview-eww markdown-mode magit lispy highlight-parentheses flycheck flex-autopair exec-path-from-shell edit-indirect cdlatex auto-complete-auctex auctex async)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
