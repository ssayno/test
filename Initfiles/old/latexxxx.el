;; set latex
;;;  you should install package as follow
;; auctex
;; auto-complete-auctex
;; cdlatex
;; latex-preview-pane
;; reftex
;; set latex
;; this background-color is pretty.
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(when (daemonp)
  (exec-path-from-shell-initialize))
;; (use-package tex
;;   :ensure auctex)
;; (use-package tex
;;   :ensure cdlatex)
;; (use-package tex
;;   :ensure latex-preview-pane)
;; (use-package tex
;;   :ensure auto-complete-auctex)
;; (use-package tex
;;   :ensure exec-path-from-shell)
(setq split-height-threshold nil)
(setq split-width-threshold 0)



;; set the shell
;; set default background color, I use solarzied theme
(add-to-list 'default-frame-alist '(background-color . "#274754"))
(add-to-list 'initial-frame-alist '(background-color . "#274754"))
(set-face-background 'fringe "#274754")
(add-hook 'LaTeX-mode-hook 'menu-bar-mode)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;; some useful mode
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; open fold function
(add-hook 'LaTeX-mode-hook 'TeX-fold-mode)
;; (setq TeX-install-font-lock 'ignore)

;; In my option, I think should open the menu-bar-mode in LaTeX-mode
(add-hook 'LaTeX-mode-hook (lambda ()
    ;;LaTeX 模式下，不打开自动折行
    (turn-off-auto-fill)
    ;; 显示行数 init.el启用
    (linum-mode 1)
    ;; 打开自动补全
    (auto-complete-mode 1)
    ;; 打开 outline mode
    (outline-minor-mode 1)
    ;; 数学模式
    ;; 接下来是和编译 TeX 有关的
    ;; 编译的时候，不在当前窗口中显示编译信息
    (setq TeX-show-compilation nil)
    (setq TeX-clean-confirm nil)
    (setq TeX-save-query nil)
    ;; 打开预览模式
))
;; 修改outline-mode的快捷键 更加的人性化
(setq outline-minor-mode-prefix [(control o)])
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; use a foolish method to get full screen and preview...mode
;; get the result of what you see is what you get
;; (add-hook 'LaTeX-mode-hook 'latex-preview-pane-mode)
;; (defun fullscreen ()
;;        (interactive)
;;        (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;;                  '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
;; (defun toggle-some-mode ()
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
;;;; 小面积估计也不是minted需要的
;; (setq preview-LaTeX-command
;;   '("%`%l -shell-escape --synctex=1\"\\nonstopmode\\nofiles\\PassOptionsToPackage{"
;;     ("," . preview-required-option-list)
;;     "}{preview}\\AtBeginDocument{\\ifx\\ifPreview\\undefined" preview-default-preamble "\\fi}\"%' \"\\detokenize{\" %(t-filename-only) \"}\""))
(add-hook 'LaTeX-mode-hook
    (lambda ()
      (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex -shell-escape --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
      (add-to-list 'TeX-command-list '("PdfLaTeX" "%`pdflatex -shell-escape --synctex=1 -8bit%(mode)%' %t" TeX-run-TeX nil t))
      (setq TeX-command-default "XeLaTeX")
      ))
(setq shell-escape-mode "-shell-escape")
;; (setq pdf-latex-command "pdflatex")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 当需要预览的时候，docview过于模糊，安装pdf-tools
;; https://github.com/politza/pdf-tools
(pdf-loader-install)
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
;; 设置背景颜色
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 配置三个基础个命令 一个用于普通xelatex 一个用于--shell-escape
;; 其实acutex默认的LaTeX和命令行的LaTeX不一样，acutex的LaTeX本质上是pdflatex
;; 所以配置或者不配置pdflatex都没有很大的必要， 也可以说是有必要的，自带的没有-8bit,可能会出现

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; set RET to C-j to (newline-and-indent), it's useful
(add-hook 'LaTeX-mode-hook '(lambda ()
(local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-cdlatex)   ; with Emacs latex mode
;; come from https://www.emacswiki.org/emacs/AutoIndentation
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
  '(setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "PDF Tools"))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;;;;;;;;;;;; reflatex and cdlatex ;;;;;;;;;;;;;;;;;
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set section and its config
(setq LaTeX-section-hook
  '(LaTeX-section-heading
  LaTeX-section-title
  ;;LaTeX-section-toc  ;; some people don't want to need.
  LaTeX-section-section
  LaTeX-section-label ;; I also don't want to need this.
  ))
;; if you don't need lable, you can use cdlatex to input section
;; sn +  TAB 
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set amsmath label
;; (setq LaTeX-amsmath-label nil)
;; set default environment
(setq LaTeX-default-environment "equation")
;; set default floats 
(setq LaTeX-float "htbp")
;; because of the C-M a can't work on my emacs
;; so I set Ctrl+Shift as prefix, it is very humanized 
(global-set-key (kbd "C-S-a") 'LaTeX-find-matching-begin)
(global-set-key (kbd "C-S-e") 'LaTeX-find-matching-end)
;; set the prefix of figure and table label
(setq LaTeX-figure-label "figure")
(setq LaTeX-table-label "table")
;; set default width for tabular* and minipage
;; not for tabular*, I can use tblr(tabularray package)
(setq LaTeX-default-width "0.45\\linewidth")
;; because table environment is used in table
;; so we set the postion to c
(setq LaTeX-default-postion "c")
(setq LaTeX-default-format "|c|c|c|")


;; set the default indent
(setq LaTeX-indent-level 4)
(setq LaTeX-item-indent 4)


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
;; 添加文件树
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)