(setq use-package-always-ensure t)
(require 'use-package-ensure)
(require 'package)
(package-initialize)
;; (add-to-list
;;  'package-archives
;;  '("melpa" . "https://melpa.org/packages/") t)
(setq package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
                         ("melpa" . "http://elpa.zilongshanren.com/melpa/")))
;; 添加额外的路径
(add-to-list 'load-path "~/.emacs.d/Initfiles/")
(setq inhibit-startup-screen t)

;;
(setq load-prefer-newer t)

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;package-refresh-contents;
;; backup and file related
;; whether generate the file~package-refresh-contents
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
;; (define-key global-map (kbd "RET" ) 'newline-and-indent)
(set-default 'tab-always-indent 'complete)
;; no mixed tab space
(defalias 'yes-or-no-p 'y-or-n-p)

;;
(scroll-bar-mode -1)
(tool-bar-mode -1)
;; menu-bar-mode is useful
(menu-bar-mode 1)

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;; add "open recent" in your "File" in your menu.
(require 'recentf)
(recentf-mode 1)

;; highlight the paren
(show-paren-mode 1)
;; delete in pair
(electric-pair-mode 1)
(global-auto-revert-mode 1)

;; (use-package yasnippet
;;   :config
;;   (yas-global-mode 1))
;; (use-package yasnippet-snippets)
(use-package counsel)
(use-package swiper
  :config
  (ivy-mode)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  ;; enable this if you want `swiper' to use it
  ;; (setq search-default-mode #'char-fold-to-regexp)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))

;; (use-package multiple-cursors
;;   :bind
;;   ("C-S-c C-S-c" . mc/edit-lines)
;;   ("C->" . mc/mark-next-like-this)
;;   ("C-<" . mc/mark-previous-like-this)
;;   ("C-c C->" . mc/mark-all-like-this))

(use-package rainbow-delimiters
  :init
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'LaTeX-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'markdown-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'org-mode-hook #'rainbow-delimiters-mode))
;; file directory structure
(use-package neotree
  :init
  (bind-key "<f8>" 'neotree-toggle))

;; check the syntax
(use-package flycheck
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
(set-frame-parameter (selected-frame) 'alpha '(85 . 50))
(add-to-list 'default-frame-alist '(alpha . (85 . 50)))
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
        '(85 . 60) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)
;; open the 'ido-mode
;; (require 'ido)
;; (ido-mode 1)
;; (setf (nth 2 ido-decorations) "\n")
;; (require 'icomplete)
;; (icomplete-mode 1)
;; (setq icomplete-separator "\n")
;; (setq icomplete-hide-common-prefix nil)
;; (setq icomplete-in-buffer t)

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
 '(LaTeX-default-environment "equation")
 '(LaTeX-default-format "|c|c|c|")
 '(LaTeX-default-postion "c" t)
 '(LaTeX-default-width "0.45\\linewidth")
 '(LaTeX-figure-label "figure")
 '(LaTeX-float "htbp")
 '(LaTeX-indent-level 4)
 '(LaTeX-item-indent 0)
 '(LaTeX-table-label "table")
 '(TeX-region "fragment")
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes '(solarized-gruvbox-dark))
 '(custom-safe-themes
   '("830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" default))
 '(fci-rule-color "#073642")
 '(highlight-changes-colors '("#d33682" "#6c71c4"))
 '(highlight-parentheses-colors '("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900"))
 '(highlight-symbol-colors
   '("#3b6b40f432d7" "#07b9463d4d37" "#47a3341f358a" "#1d873c4056d5" "#2d87441c3362" "#43b7362e3199" "#061e418059d7"))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   '(("#073642" . 0)
	 ("#5b7300" . 20)
	 ("#007d76" . 30)
	 ("#0061a8" . 50)
	 ("#866300" . 60)
	 ("#992700" . 70)
	 ("#a00559" . 85)
	 ("#073642" . 100)))
 '(hl-bg-colors
   '("#866300" "#992700" "#a7020a" "#a00559" "#243e9b" "#0061a8" "#007d76" "#5b7300"))
 '(hl-fg-colors
   '("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36"))
 '(hl-paren-colors '("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900"))
 '(latex-preview-pane-multifile-mode 'auctex)
 '(lsp-ui-doc-border "#93a1a1")
 '(nrepl-message-colors
   '("#dc322f" "#cb4b16" "#b58900" "#5b7300" "#b3c34d" "#0061a8" "#2aa198" "#d33682" "#6c71c4"))
 '(outline-minor-mode-prefix [(control o)])
 '(package-selected-packages
   '(latex-preview-pane yasnippet-snippets use-package solarized-theme rainbow-delimiters pdf-tools neotree markdown-preview-eww markdown-mode magit lispy highlight-parentheses flycheck flex-autopair exec-path-from-shell edit-indirect auto-complete-auctex auctex async))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(show-paren-mode t)
 '(show-paren-style 'mixed)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(synctex-number "1")
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   '((20 . "#dc322f")
	 (40 . "#cb4466ec20b5")
	 (60 . "#c11679431550")
	 (80 . "#b58900")
	 (100 . "#a6ae8f7c0000")
	 (120 . "#9ed992380000")
	 (140 . "#96bf94d00000")
	 (160 . "#8e5497440000")
	 (180 . "#859900")
	 (200 . "#77689bfc4636")
	 (220 . "#6d449d475bfe")
	 (240 . "#5fc09ea47093")
	 (260 . "#4c69a01784aa")
	 (280 . "#2aa198")
	 (300 . "#303598e7affc")
	 (320 . "#2fa1947dbb9b")
	 (340 . "#2c889009c736")
	 (360 . "#268bd2")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#002b36" "#073642" "#a7020a" "#dc322f" "#5b7300" "#859900" "#866300" "#b58900" "#0061a8" "#268bd2" "#a00559" "#d33682" "#007d76" "#2aa198" "#839496" "#657b83"))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "SlateBlue2"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "light steel blue"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "OliveDrab2"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "navy"))))
 '(show-paren-match ((((class color) (min-colors 89)) (:foreground "#00869b" :background unspecified :weight bold)))))
