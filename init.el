;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Section1: 杂项-Emacs关于一些目录和简单功能的开启或关闭
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "~/.emacs.d/site-lisp/subdirs")
(server-start)

;; 把所有备份文件移到~/.emacs.d/tmp目录下(/tmp目录下文件没有备份文件)
(setq backup-directory-alist '(("." . "~/.emacs.d/tmp")))
;;(setq auto-save-default nil)
(setq auto-save-file-name-transforms
         '(("\\`/[^/]*:\\([^/]*/\\)*\\([^/]*\\)\\'" "~/.emacs.d/tmp/\\2" t)
                   ("\\`/?\\([^/]*/\\)*\\([^/]*\\)\\'" "~/.emacs.d/tmp/\\2" t)))
(setq auto-save-list-file-prefix "~/.emacs.d/tmp/.saves-")

;;语法加亮功能
(setq enable-local-variables t)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;;历史记录
(require 'session)
(setq session-save-file "~/.emacs.d/.session"
            session-save-file-coding-system 'utf-8)
(add-hook 'after-init-hook 'session-initialize)

;; 自定义函数，保存时不备份文件，在gnus用到
(defun turn-off-backup ()
    (set (make-local-variable 'backup-inhibited) t))

;; 高亮显示匹配的括号
(show-paren-mode t)

;; 显示列号
(column-number-mode t)

;; 高亮显示区域
(transient-mark-mode t) ;; 这个Emacs自带，但不够好，中间的行会整行高亮显示
;; 我们用rect-mark.el来加强
(define-key ctl-x-map "r\C-@" 'rm-set-mark)
(define-key ctl-x-map [?r ?\C-\ ] 'rm-set-mark)
(define-key ctl-x-map "r\C-x" 'rm-exchange-point-and-mark)
(define-key ctl-x-map "r\C-w" 'rm-kill-region)
(define-key ctl-x-map "r\M-w" 'rm-kill-ring-save)
(define-key global-map [S-down-mouse-1] 'rm-mouse-drag-region)
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

;; Todo设置
(setq todo-file-do   "~/.emacs.d/todo-do"
      todo-file-done "~/.emacs.d/todo-done"
      todo-file-top  "~/.emacs.d/todo-top"
)

;; 使用系统剪贴版，以便与其它X程序间互相复制粘贴数据
(setq x-select-enable-clipboard 1)

;; buffer中显示行号
(require 'setnu+)

;; 自动补全
(global-set-key [(meta ?/)] 'hippie-expand)
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

;; 自动补全括号和引号
(setq skeleton-pair t)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\'") 'skeleton-pair-insert-maybe)

;; 移动一行
(global-set-key [(meta up)] 'move-line-up)
(global-set-key [(meta down)] 'move-line-down) 

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

;; 在行中开启新的一行
(global-set-key [(control o)] 'vi-open-next-line)

(defun vi-open-next-line (arg)
 "Move to the next line (like vi) and then opens a line."
 (interactive "p")
 (end-of-line)
 (open-line arg)
 (next-line 1)
 (indent-according-to-mode)) 

;; 如果没有选中区域，在行中复制、剪切一行
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

;; 用ASCII绘制表格
(require 'table)
(add-hook 'text-mode-hook 'table-recognize)

;; Section1 End

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Section2: Emacs版本相关的一些设置
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(if (> emacs-major-version 22)
;;  (set-language-environment 'Chinese-GB18030))

;;(if (< emacs-major-version 22)
;;  (load "~/.emacs.d/oldconf"))

;; Section2 End

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Section3: 操作系统相关的设置
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (or (string= system-type "windows-nt") (string= system-type "ms-dos"))
    (load "mswin.el"))

(if (string= system-type "gnu/linux")
    (load "linux.el"))

;; Section3 End

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Section4: 界面相关设置
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 我的Color theme，标签栏
(require 'color-theme)
(require 'tabbar)
(when window-system
  	(color-theme-gnome2)
	(tabbar-mode)
)

;; 启动时默认窗口大小
;;(setq default-frame-alist
;; '((height . 30) (width . 80)))

;; Section4 End

;;;;;;;;;;;;;;;;;;;;;;
;;
;; Section5: Web支持
;;
;;;;;;;;;;;;;;;;;;;;;;

;; 使用 Emacs-w3m
(setq w3m-icon-directory "~/.emacs.d/misc/pixmaps/w3m-el")
(require 'w3m-load)
(setq w3m-use-cookies t)

;; 调用firefox查看buffer中的url地址
(defun browse-url-firefox-new-tab (url &optional new-window)
     "Open URL in a new tab in Mozilla."
        (interactive (browse-url-interactive-arg "URL: "))
	(unless
	   (string= ""
		    (shell-command-to-string
                       (concat "mozilla-firefox -a firefox -remote 'openURL(" url ",new-tab)'"))
           )
	     (message "Starting Mozilla Firefox...")
	)
)(setq browse-url-browser-function 'browse-url-firefox-new-tab)

;; Section5 End

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Section6: 语法文件
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; folding
(if (load "folding" 'nomessage 'noerror)
    (folding-mode-add-find-file-hook))

;rst语法
(require 'rst)
(add-hook 'text-mode-hook 'rst-text-mode-bindings)
(setcdr (assq 'html rst-compile-toolsets)
      '("rst2html" ".html"))

;; asciidoc
(autoload 'doc-mode "doc-mode" nil t)
;;(add-to-list 'auto-mode-alist '("\\.txt$" . doc-mode))
(add-hook 'doc-mode-hook
	  '(lambda ()
	     (turn-on-auto-fill)
	     (require 'asciidoc)))

;;python语法支持
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                              interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;; python-mode-hook
(add-hook 'python-mode-hook 'my-python-hook)
;; outline for python
;; judge level by column
(defun py-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
      (skip-chars-forward "\t ")
      (+ (/ (current-column) 4) 1))))

;; called after python mode is enabled
(defun my-python-hook ()
  ;; what is headings
  (setq outline-regexp "[ \t]*\\(def\\|class\\|if\\|elif\\|else\\|while\\|for\\|try\\|except\\|finally|with\\) ")
  ;; enable our level computation
  (setq outline-level 'py-outline-level)
  ;; do not use their \C-c@ prefix, too hard to type. Note this overides some python mode bindings
  (setq outline-minor-mode-prefix "\C-c")
  ;; turn on outline mode
  (outline-minor-mode t)
  ;; initially hide all but the headers
  (hide-body)
)

(if (executable-find "ipython")
	(require 'ipython))

;; pymacs, ropemacs
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

;;xml
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

;;pdf
(setq doc-view-cache-directory "~/.emacs.d/tmp")

;; Section6 End

;;;;;;;;;;;;;;;;;;;;;;
;;
;; Section7: 键绑定
;;
;;;;;;;;;;;;;;;;;;;;;;
(global-set-key "\C-ct" 'todo-show)
(global-set-key "\C-ci" 'todo-insert-item)

;; Section7 End

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Section8: 邮件相关设置
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gnus相关的一些配置
(setq gnus-site-init-file "~/.emacs.d/gnus/gnus.el")
(setq gnus-home-directory "~/.emacs.d/gnus")
(setq gnus-startup-file "~/.emacs.d/gnus/.newsrc")
(setq message-directory "~/.emacs.d/gnus/mail/")
(setq message-auto-save-directory "~/.emacs.d/gnus/Mail/drafts")
(setq gnus-directory "~/.emacs.d/gnus/news")
(setq nnmail-message-id-cache-file "~/.emacs.d/gnus/.nnmail-cache")
(setq mail-source-crash-box "~/.emacs.d/gnus/.emacs-mail-crash-box")

;; 以下配置Emacs版的SMTP Daemon
(setq user-full-name "foo")
(setq user-mail-address "foo@163.com")

;;若使用.authinfo验证，可注释掉2个credentials变量，密码处可为nil，则每次发信均须输入密码
(setq
    smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
    smtpmail-auth-credentials '(("smtp.gmail.com" 587 "foo@gmail.com" "mypassword"))
    ;;smtpmail-auth-credentials "~/.emacs.d/.authinfo"
    smtpmail-default-smtp-server "smtp.gmail.com"
    smtpmail-smtp-server "smtp.gmail.com"
    smtpmail-local-domain "gmail.com"
    smtpmail-smtp-service 587
    send-mail-function 'smtpmail-send-it
    message-send-mail-function 'smtpmail-send-it
    smtpmail-debug-info t)

(load-library "smtpmail")

;; Section8 End

;;;;;;;;;;;;;;;;;;;;;;
;;
;; Section9: 搜索增强
;;
;;;;;;;;;;;;;;;;;;;;;;

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

;; Section9 End

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Section10: 开发环境
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-insert设置
(require 'autoinsert)
;; Adds hook to find-files-hook
(auto-insert-mode)
;; 注意路径中最后的斜杠不能省，但我们并不使用它
;; 我们使用skeleton，因为可以定位光标
;;(setq auto-insert-directory "~/.emacs.d/templates/")
;; 插入时不提示
(setq auto-insert-query nil)
(load "myskeletons.el")
(setq auto-insert-alist '(
            ;;{{{ Rst
            ;; rst-mode不是major mode，所以不能根据rst-mode触发
            (("\\.rst$" . "Rst File") . rst-skeleton)
            ;;}}}

            ;;{{{ Python
            ((python-mode . "Python File") . python-skeleton)
            ;;}}}
            )
)

;; yasnippet
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/misc/snippets/")

;; Section10 End

