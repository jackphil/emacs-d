;#全局设置: 杂项-Emacs关于一些目录和简单功能的开启或关闭

;;#启动服务端
(server-start)

;;#本地插件目录
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
        (let* ((my-lisp-dir "~/.emacs.d/site-lisp")
               (default-directory my-lisp-dir))
         (setq load-path (cons my-lisp-dir load-path))
 (normal-top-level-add-subdirs-to-load-path)))

;;#备份和自动缓存文件目录
;;把所有备份文件移到~/.emacs.d/tmp目录下(/tmp目录下文件没有备份文件)
(setq backup-directory-alist '(("." . "~/.emacs.d/tmp")))
;;(setq auto-save-default nil)
(setq auto-save-file-name-transforms
         '((".*" "~/.emacs.d/tmp/" t))
)
(setq auto-save-list-file-prefix "~/.emacs.d/tmp/.saves-")

;;#历史记录
(require 'session)
(setq session-save-file "~/.emacs.d/.session"
            session-save-file-coding-system 'utf-8)
(add-hook 'after-init-hook 'session-initialize)

;;#界面设置
;;;#如果是图形界面才使用color-theme和标签页
(when window-system
  (load-theme 'tango-dark t)
)

;;;#隐藏菜单和工具栏
(tool-bar-mode -1) 
(menu-bar-mode -1)

;;;#启动时默认窗口大小，见linux.el

;;#显示列号
(column-number-mode t)

;;高亮显示区域
(transient-mark-mode t) ;; 这个Emacs自带，但不够好，中间的行会整行高亮显示
;;我们用rect-mark.el来加强。
(autoload 'rm-set-mark "rect-mark"
	    "Set mark for rectangle." t)
(autoload 'rm-exchange-point-and-mark "rect-mark"
	    "Exchange point and mark for rectangle." t)
(autoload 'rm-kill-region "rect-mark"
	    "Kill a rectangular region and save it in the kill ring." t)
(autoload 'rm-kill-ring-save "rect-mark"
	    "Copy a rectangular region to the kill ring." t)
(autoload 'rm-mouse-drag-region "rect-mark"
	    "Drag out a rectangular region with the mouse." t)
(add-hook 'picture-mode-hook 'rm-example-picture-mode-bindings)
(autoload 'rm-example-picture-mode-bindings "rect-mark"
	    "Example rect-mark key and mouse bindings for picture mode.")

;;使用系统剪贴版，以便与其它X程序间互相复制粘贴数据
(setq x-select-enable-clipboard 1)

;;#如果没有选中区域，在行中复制、剪切一行
(defadvice kill-ring-save (before slickcopy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
   (line-beginning-position 2)))))

(defadvice kill-region (before slickcut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
   (line-beginning-position 2)))))

;;#语法加亮功能
(setq enable-local-variables t)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;;#自动补全括号和引号
(setq skeleton-pair t)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\'") 'skeleton-pair-insert-maybe)

;;#高亮显示匹配的括号
(show-paren-mode t)

;;#搜索增强
(autoload 'igrep "igrep"
       "*Run `grep` PROGRAM to match REGEX in FILES..." t)
(autoload 'igrep-find "igrep"
       "*Run `grep` via `find`..." t)
(autoload 'igrep-visited-files "igrep"
      "*Run `grep` ... on all visited files." t)
(autoload 'dired-do-igrep "igrep"
       "*Run `grep` on the marked (or next prefix ARG) files." t)
(autoload 'dired-do-igrep-find "igrep"
       "*Run `grep` via `find` on the marked (or next prefix ARG) directories." t)
(autoload 'Buffer-menu-igrep "igrep"
      "*Run `grep` on the files visited in buffers marked with '>'." t)
(autoload 'igrep-insinuate "igrep"
      "Define `grep' aliases for the corresponding `igrep' commands." t)
(autoload 'grep "igrep"
       "*Run `grep` PROGRAM to match REGEX in FILES..." t)
(autoload 'egrep "igrep"
       "*Run `egrep`..." t)
(autoload 'fgrep "igrep"
       "*Run `fgrep`..." t)
(autoload 'agrep "igrep"
       "*Run `agrep`..." t)
(autoload 'grep-find "igrep"
       "*Run `grep` via `find`..." t)
(autoload 'egrep-find "igrep"
       "*Run `egrep` via `find`..." t)
(autoload 'fgrep-find "igrep"
       "*Run `fgrep` via `find`..." t)
(autoload 'agrep-find "igrep"
       "*Run `agrep` via `find`..." t)
(setq igrep-case-fold-search t)

;#快捷键(所有自定义快捷键都集中在这里)

;;#rect-mark.el
;;标记开始: C-x r C-@
(define-key ctl-x-map "r\C-@" 'rm-set-mark)
;;在区块首尾间跳转: C-x r C-x
(define-key ctl-x-map "r\C-x" 'rm-exchange-point-and-mark)
;;剪切区块: C-x r C-w
(define-key ctl-x-map "r\C-w" 'rm-kill-region)
;;复制区块: C-x r M-w
(define-key ctl-x-map "r\M-w" 'rm-kill-ring-save)
;;鼠标操作
(define-key global-map [S-down-mouse-1] 'rm-mouse-drag-region)

;;#交换相邻两行
;;与上一行交换: M-Up(向上方向键)
(global-set-key [(meta up)] 'move-line-up)
;;与下一行交换: M-Down
(global-set-key [(meta down)] 'move-line-down) 

;;;#辅助函数
(defun move-line (&optional n)
 "Move current line N (1) lines up/down leaving point in place."
 (interactive "p")
 (when (null n)
    (setq n 1))
 (let ((col (current-column)))
    (beginning-of-line)
    (next-line 1)
    (transpose-lines n)
    (previous-line 1)
    (forward-char col)))

(defun move-line-up (n)
 "Moves current line N (1) lines up leaving point in place."
 (interactive "p")
 (move-line (if (null n) -1 (- n)))) 

(defun move-line-down (n)
 "Moves current line N (1) lines down leaving point in place."
 (interactive "p")
 (move-line (if (null n) 1 n))) 

;;#在行中开启新的一行，C-o
(global-set-key [(control o)] 'vi-open-next-line)

;;;#辅助函数
(defun vi-open-next-line (arg)
 "Move to the next line (like vi) and then opens a line."
 (interactive "p")
 (end-of-line)
 (open-line arg)
 (next-line 1)
 (indent-according-to-mode)) 

;;#hippie代码自动完成: M-/
(global-set-key [(meta ?/)] 'hippie-expand)

;#Emacs版本相关的一些设置
;;(if (> emacs-major-version 22)
;;  (set-language-environment 'Chinese-GB18030))

;;(if (< emacs-major-version 22)
;;  (load "~/.emacs.d/oldconf"))

;#操作系统相关的设置
;;#Windows系统加载mswin.el
(if (or (string= system-type "windows-nt") (string= system-type "ms-dos"))
    (load "mswin.el"))
;;#linux系统加载linux.el
(if (string= system-type "gnu/linux")
    (load "linux.el"))

;#语法文件

;;#用ASCII绘制表格
(require 'table)
(add-hook 'text-mode-hook 'table-recognize)

;;#rst语法
(require 'rst)
(add-hook 'text-mode-hook 'rst-text-mode-bindings)
(setcdr (assq 'html rst-compile-toolsets)
      '("rst2html" ".html"))

;;#asciidoc
(require 'adoc-mode)
(add-to-list 'auto-mode-alist '("\\.txt$" . adoc-mode)) 

;;#elisp
(add-hook 'emacs-lisp-mode-hook
	  (lambda() (setq outline-regexp "^[;]+#")
	  ;;(setq outline-minor-mode-prefix "\C-c")
	  ;; turn on outline mode
	  (outline-minor-mode t)
))

;;#python语法支持
;;;#python-mode主要是语法高亮和格式化
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                              interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;;;;#python-mode-hook
(add-hook 'python-mode-hook 'my-python-hook) 

;;;;;#辅助函数my-python-hook
(defun my-python-hook ()
  ;; what is headings
  (setq outline-regexp "[ \t]*\\(def\\|class\\|if\\|elif\\|else\\|while\\|for\\|try\\|except\\|finally|with\\) ")
  ;; enable our level computation
  (setq outline-level 'py-outline-level)
  ;; turn on outline mode
  (outline-minor-mode t)
  ;; initially hide all but the headers
  (hide-body)
)

;;;;;;#辅助函数: outline for python
;;judge level by column
(defun py-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
      (skip-chars-forward "\t ")
      (+ (/ (current-column) 4) 1))))

;;;#ipython
(if (executable-find "ipython")
	(require 'ipython))

;;;#pymacs, ropemacs
(setq pymacs-load-path '("~/.emacs.d/misc/rope-0.9.1"
                           "~/.emacs.d/misc/ropemacs-0.6"))
(defun load-ropemacs ()
    "Load pymacs and ropemacs"
    (interactive)
    (require 'pymacs)
    (pymacs-load "ropemacs" "rope-")
    ;; Automatically save project python buffers before refactorings
    (setq ropemacs-confirm-saving 'nil)
  )
(global-set-key "\C-xpl" 'load-ropemacs)

;;# shell script
;; outline symbol is "#" and "$"
;; they are close on the keyboard
(add-hook 'sh-mode-hook
	  (lambda() (setq outline-regexp "^[#]+[$]")
	  ;; turn on outline mode
	  (outline-minor-mode t)
))

;;#xml
(load "rng-auto.el")
(setq auto-mode-alist
      (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
            auto-mode-alist))
(mapc
     (lambda (pair)
       (if (or (eq (cdr pair) 'xml-mode)
               (eq (cdr pair) 'sgml-mode)
               (eq (cdr pair) 'html-mode))
           (setcdr pair 'nxml-mode)))
     magic-mode-alist)


;#模板和自动完成
;;#新建文件时的模板
;;;#auto-insert设置
(require 'autoinsert)
;;Adds hook to find-files-hook
(auto-insert-mode)
;;注意路径中最后的斜杠不能省，但我们并不使用它 
;;(setq auto-insert-directory "~/.emacs.d/templates/")
;;;#我们使用skeleton，因为可以定位光标
;;插入时不提示
(setq auto-insert-query nil)
(load "myskeletons.el")
(setq auto-insert-alist '(
;;;;#Rst
	    ;; rst-mode不是major mode，所以不能根据rst-mode触发
            (("\\.rst$" . "Rst File") . rst-skeleton) 

;;;;#Python
            ((python-mode . "Python File") . python-skeleton) 
            )
)

;;#写类、函数、循环等时的模板
;;注意不同于代码自动提示(函数名、参数等等)
;;;#我们使用yasnippet
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/misc/snippets/")

;;#自动补全

;;#代码自动完成
;;;#通用的是hippie，根据文件内已有数据、缩写等猜测补全
(setq hippie-expand-try-functions-list 
      '(try-expand-dabbrev
       	try-expand-dabbrev-visible
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-list
	try-expand-line
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol))
