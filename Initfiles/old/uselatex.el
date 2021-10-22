;; set latex
(require 'tex)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;; set rainbow-delimiter can work in LaTeX


;; (setq TeX-install-font-lock 'ignore)
(add-hook 'LaTeX-mode-hook (lambda ()
    ;;LaTeX 模式下，不打开自动折行
    (turn-off-auto-fill)
    ;; 显示行数 init.el启用，这里不启用
    (linum-mode 0)
    ;; 打开自动补全
    (auto-complete-mode 1)
    ;; 打开 outline mode
    (outline-minor-mode 1)
    ;; 接下来是和编译 TeX 有关的
    ;; 编译的时候，不在当前窗口中显示编译信息
    (setq TeX-show-compilation nil)
    (setq TeX-clean-confirm nil)
    (setq TeX-save-query nil)
    ;; 打开预览模式
))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; get the result of what you see is what you get
;; (add-hook 'LaTeX-mode-hook 'latex-preview-pane-mode)
(defun mypreview ()
  "my key for preview latex"
  (interactive)
  (local-set-key (kbd "C-c p") 'latex-preview-pane-mode))
(add-hook 'LaTeX-mode-hook 'mypreview)
(setq pdf-latex-command "xelatex")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 配置三个基础个命令 一个用于普通xelatex 一个用于--shell-escape
;; 其实acutex默认的LaTeX和命令行的LaTeX不一样，acutex的LaTeX本质上是pdflatex
;; 所以配置或者不配置pdflatex都没有很大的必要， 也可以说是有必要的，自带的没有-8bit,可能会出现
(add-hook 'LaTeX-mode-hook
    (lambda ()
      (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
      (add-to-list 'TeX-command-list '("XeLaTeX-shell" "%`xelatex --shell-escape --synctex=1 -8bit%(mode)%' %t" TeX-run-TeX nil t))
      (add-to-list 'TeX-command-list '("pdfLaTeX" "%`pdflatex --synctex=1 -8bit%(mode)%' %t" TeX-run-TeX nil t))
      (setq TeX-command-default "XeLaTeX")
      ))


;; set paranthese
(setq TeX-electric-math (cons "$" "$"))
  (define-skeleton quoted-parentheses
    "Insert \\( ... \\)."
    nil "(" _ ")")

(define-skeleton quoted-brackets
  "Insert \\[ ... \\]."
  nil "\\[" _ "\\]")
(defun paranthese ()
  "paranthese"
  (interactive)
  (local-set-key (kbd "C-9") (cons "(" ")")))
(defun bracket ()
  "bracket"
  (interactive)
  (local-set-key (kbd "M-[") 'quoted-brackets))

(add-hook 'LaTeX-mode-hook 'paranthese)
(add-hook 'LaTeX-mode-hook 'bracket)

;; set RET to C-j to (newline-and-indent), it's useful
(add-hook 'LaTeX-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))

;; come from https://www.emacswiki.org/emacs/AutoIndentation


(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; set () autopair
(add-hook 'LaTeX-mode-hook 'electric-pair-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
;; use cdlatex
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with AUCTeX LaTeX mode
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with Emacs latex mode

(setq LaTeX-electric-left-right-brace t)

;;;; set parathesis

(require 'smartparens-latex)

(add-hook 'LaTeX-mode-hook #'smartparens-mode)
(add-hook 'latex-mode-hook #'smartparens-mode)

;; set okular
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;        LaTeX         ;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ##### Don't forget to configure
;; ##### Okular to use emacs in
;; ##### "Configuration/Configure Okular/Editor"
;; ##### => Editor => Emacsclient. (you should see
;; ##### emacsclient -a emacs --no-wait +%l %f
;; ##### in the field "Command".

;; ##### Always ask for the master file
;; ##### when creating a new TeX file.

;; ##### Enable synctex correlation. From Okular just press
;; ##### Shift + Left click to go to the good line.
(setq TeX-source-correlate-mode t
      TeX-source-correlate-start-server t)

;; ### Set Okular as the default PDF viewer.
(eval-after-load "tex"
  '(setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "Okular"))


;; ;; set reftex with auctex
;; set reftex
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(autoload 'reftex-mode "reftex"
  "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex"
  "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite"
  "Make citation" nil)
(autoload 'reftex-index-phrase-mode
  "reftex-index" "Phrase mode" t)

;; set menu
(add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'reftex-mode-hook 'imenu-add-menubar-index)
(global-set-key [down-mouse-3] 'imenu)
;; 
;;*toc*buffer 在左侧。
;;(setq reftex-toc-split-windows-horizontally t)
;;*toc*buffer 使用整个 frame 的比例。
(setq reftex-toc-split-windows-fraction 0.5)



;; (add-hook 'LaTeX-mode-hook
;;   (lambda () (set (make-local-variable 'TeX-electric-math)
;;   (cons "\\(" "\\)"))))

;; set autopair
;; (setq LaTeX-electric-left-right-brace t)

;; set section and its config
(setq LaTeX-section-hook
  '(LaTeX-section-heading
  LaTeX-section-title
  ;;LaTeX-section-toc  ;; some people don't want to need.
  LaTeX-section-section
  ;;LaTeX-section-label ;; I also don't want to need this.
  ))


;; set amsmath label
(setq LaTeX-amsmath-label nil)


;; set default environment
(setq LaTeX-default-environment "equation")


;; set default floats 
(setq LaTeX-float "ht")

;; set default engine
;; (setq TeX-engine 'xetex)


;; set default width for tabular* and minipage
;; not for tabular*, I can use tblr(tabularray package)
(setq LaTeX-default-width "0.45\\linewidth")

;; when invoke "insert marco", set the default marco
;; (setq TeX-default-marco "verb") false I can't understand

