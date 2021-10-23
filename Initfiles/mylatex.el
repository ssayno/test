;;; package --- Summary
;;; Commentary:
;;; Code:
;; 安装(highlight-parentheses-mode ，让圆括号也是可以有
(add-hook 'LaTeX-mode-hook
          '(lambda ()
             (highlight-parentheses-mode)
             (setq autopair-handle-action-fns
                   (list 'autopair-default-handle-action
                         '(lambda (action pair pos-before)
                            (hl-paren-color-update))))))
;; when open tex file, load LaTeX-mode automaticlly
(add-to-list 'auto-mode-alist '("\\.tex$" . LaTeX-mode))
;; set the shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  (when (daemonp)
    (exec-path-from-shell-initialize))
  (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on))


(use-package tex
  :ensure auto-complete-auctex)
(use-package cdlatex
  :ensure t
  :config
  (require 'cdlatex)
  (setq cdlatex-paired-parens "$[{(")
  (defun my-after-load-cdlatex ()
    (define-key cdlatex-mode-map "_" nil) t)
  (eval-after-load "cdlatex" '(my-after-load-cdlatex))
  (setq TeX-electric-sub-and-superscript t))

;; 让垂直拆分
;; (setq split-height-threshold nil)
;; (setq split-width-threshold 0)
(use-package tex
  :ensure auctex
  :config
  (customize-set-variable 'TeX-region "fragment")
  (setq TeX-auto-save t)
  (setq-default TeX-parse-self t)
  (setq-default TeX-master nil)
  ;; In my option, I think should open the menu-bar-mode in LaTeX-mode
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook (lambda ()
                               ;;LaTeX 模式下，不打开自动折行
                               (turn-off-auto-fill)
                               ;; 显示行数 init.el启用
                               (linum-mode 1)
                               ;; 打开自动补全
                               (auto-complete-mode 1)
                               ;; 打开 outline mode
                               (outline-minor-mode 1)
                               ;; 菜单和latex-mode还是挺搭的
                               (menu-bar-mode 1)
                               ;; 不知道的模式
                               (visual-line-mode 1)
                               ;; 折叠模式
                               (TeX-fold-mode 1)
                               ;; 不知道的模式，我还加载不了
                               ;; (flyspell-mode 1)
                               ;; 接下来是和编译 TeX 有关的
                               ;; 编译的时候，不在当前窗口中显示编译信息
                               (customize-set-variable 'TeX-show-compilation nil)
                               (customize-set-variable 'TeX-clean-confirm nil)
                               (customize-set-variable 'TeX-save-query nil)
                               ;; 打开预览模式
                               ))
  ;; 修改outline-mode的快捷键 更加的人性化
  (customize-set-variable 'outline-minor-mode-prefix [(control o)])

  ;; 当需要预览的时候，docview过于模糊，安装pdf-tools
  ;; https://github.com/politza/pdf-tools
  
  (use-package pdf-tools
	:ensure t
	:config
	(pdf-loader-install))
  (require 'tex-buf)
  (add-hook 'TeX-after-compilation-finished-functions 'TeX-revert-document-buffer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; 其实acutex默认的LaTeX和命令行的LaTeX不一样，acutex的LaTeX本质上是pdflatex
  ;; 所以配置或者不配置pdflatex都没有很大的必要， 也可以说是有必要的，自带的没有-8bit,可能会出现
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex -shell-escape --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
              (add-to-list 'TeX-command-list '("PdfLaTeX" "%`pdflatex -shell-escape --synctex=1 -8bit%(mode)%' %t" TeX-run-TeX nil t))
              (setq TeX-command-default "XeLaTeX")
              ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; set RET to C-j to (newline-and-indent), it's useful
  (add-hook 'LaTeX-mode-hook '(lambda ()
                                (local-set-key (kbd "RET") 'newline-and-indent)))
  (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex) ; with AUCTeX LaTeX mode
  (add-hook 'latex-mode-hook 'turn-on-cdlatex) ; with Emacs latex mode
  ;; come from https://www.emacswiki.org/emacs/AutoIndentation
  ;; set pdf-tools as the basic pdf viewer
  (setq TeX-source-correlate-mode t
        TeX-source-correlate-start-server t)
  (eval-after-load "tex"
    '(setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "PDF Tools"))
  ;; if you don't need lable, you can use cdlatex to input section
  ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; set amsmath label
  ;; (setq LaTeX-amsmath-label nil)
  ;; set default environment
  (customize-set-variable 'LaTeX-default-environment "equation")
  ;; set default floats
  (customize-set-variable 'LaTeX-float "htbp")
  ;; because of the C-M a can't work on my emacs
  ;; so I set Ctrl+Shift as prefix, it is very humanized
  (global-set-key (kbd "C-S-a") 'LaTeX-find-matching-begin)
  (global-set-key (kbd "C-S-e") 'LaTeX-find-matching-end)
  ;; set the prefix of figure and table label
  (customize-set-variable 'LaTeX-figure-label "figure")
  (customize-set-variable 'LaTeX-table-label "table")
  ;; set default width for tabular* and minipage
  ;; not for tabular*, I can use tblr(tabularray package)
  (customize-set-variable 'LaTeX-default-width "0.45\\linewidth")
  ;; because table environment is used in table
  ;; so we set the postion to c
  (customize-set-variable 'LaTeX-default-postion "c")
  (customize-set-variable 'LaTeX-default-format "|c|c|c|")


  ;; set the default indent
  (customize-set-variable 'LaTeX-indent-level 4)
  (customize-set-variable 'LaTeX-item-indent 0)
  ;; get singe _ and ^ in auctex
  (setq TeX-electric-sub-and-superscript t)

  ;;设置局部绑定键位
  (defun myclean ()
    "clean the auxiliary file"
    (interactive)
    (local-set-key (kbd "<f5>") 'TeX-clean))
  (add-hook 'LaTeX-mode-hook 'myclean)

  (defun mytexdoc ()
    "clean the auxiliary file"
    (interactive)
    (local-set-key (kbd "<f6>") 'TeX-documentation-texdoc))
  (add-hook 'LaTeX-mode-hook 'mytexdoc)
  ;; 由于使用中文较多，使用xetex引擎
  ;; 其实设不设置没啥必要，当你编译的使用会自己给你选好
  (setq TeX-engine 'xetex)
  ;; 使用minted等一些其他宏包的时候，需要额外编译选项
  (setq TeX-command-extra-options "-shell-escape")
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;; reflatex and cdlatex ;;;;;;;;;;;;;;;;;
;; reftex 伴随这Emacs一起来了
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


(define-skeleton quoted-brackets
      "Insert \\[ ... \\]."
      nil "\\[" _ "\\]")
(global-set-key "\C-x[" 'quoted-brackets)


;; preview-latex-pane 被我舍弃掉了，并不是那么好用，等会我设置他的正反搜索再启用
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; use a foolish method to get full screen and preview...mode                     ;;;;;;;;
;; get the result of what you see is what you get                                 ;;;;;;;;
;; (defun fullscreen ()                                                           ;;;;;;;;
;;        (interactive)                                                           ;;;;;;;;
;;        (x-send-client-message nil 0 nil "_NET_WM_STATE" 32                     ;;;;;;;;
;;                  '(2 "_NET_WM_STATE_FULLSCREEN" 0)))                           ;;;;;;;;
;; (defun toggle-some-mode ()                                                     ;;;;;;;;
;;   (interactive)
;;   (if (bound-and-true-p latex-preview-pane-mode)
;;     (progn (fullscreen) (latex-preview-pane-mode 0))
;;     (progn (fullscreen) (latex-preview-pane-mode 1))))
;; (defun mypreview ()
;;   "my key for preview latex"
;;   (interactive)
;;   (local-set-key (kbd "C-c p") 'toggle-some-mode))
;; (add-hook 'LaTeX-mode-hook 'mypreview)
;; 设置预览的编译器
;; 给编译选项加上 -shell-escape
;; (setq shell-escape-mode "-shell-escape")
;; (setq pdf-latex-command "pdflatex")
(provide 'mylatex)
;;; mylatex.el ends here
