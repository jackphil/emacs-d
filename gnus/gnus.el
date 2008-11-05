;; 设置邮件后端(服务器)，这里使用nnfolder
(setq gnus-select-method '(nnfolder "mail"
;;      			(nnfolder-get-new-mail t)
                          )
)

(add-hook 'nnfolder-save-buffer-hook 'turn-off-backup)


;; 设置使用新闻服务器
(setq gnus-secondary-select-methods '((nntp "msnews.microsoft.com")
				      (nntp "news.cn99.com")
				     )
)

;; 告诉gnus从哪里取邮件：定义mail-soureces，第一句使用了支持ssl的pop3版本
(eval-after-load "mail-source" '(require 'pop3))
(setq mail-sources '(

			(file :path "/var/mail/foo")

			(pop :server "pop.163.com" 
			     :user "foo1"
			     :password "mypassword"
			     )

			(pop :server "pop.mail.yahoo.com.cn"
			     :user "foo2"
			     :password "mypassword"
			     )

			(pop :server "pop.mail.yahoo.com.cn"
			     :user "foo3"
			     :password "mypassword"
			     )

			(pop :server "pop.gmail.com"
			     :port 995
			     :user "foo4@gmail.com"
			     :connection ssl
			     :password "mypassword"
			     )
			))


;; 分送邮件到各组
(setq nnmail-treat-duplicates 'delete
      nnmail-crosspost nil
      nnmail-split-methods 'nnmail-split-fancy
      nnmail-split-fancy
      '(|
        (any "python-chinese@lists\\.python\\.cn\\|python-cn@googlegroups\\.com" "mail.python-chinese")
	(any "smfang@yahoo\\.com" "mail.xys")
	(any "emacs-devel@gnu\\.org" "mail.Emacs-devel")
	(any "help-gnu-emacs@gnu\\.org" "mail.Emacs-help")	
	(any "ding@gnus\\.org" "mail.Gnus-ding")
	(any "mingw-users" "mail.Mingw-users")
	(any "ubuntu-users" "mail.Ubuntu-users")
	(any "ubuntu-zh" "mail.Ubuntu-zh")
        "mail.misc"))

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; 使用w3-m查看html格式的邮件，并打开图片显示功能
(setq mm-text-html-renderer 'w3m)
(setq mm-inline-text-html-with-images t)

(setq gnus-save-newsrc-file nil
       gnus-use-cache t
       message-kill-buffer-on-exit t
       message-make-forward-subject-function
       	'(message-forward-subject-fwd)
       message-forward-as-mime nil
       gnus-asynchronous t
)

(setq gnus-parameters
      '(("mail\\..*" (total-expire . t))
       )
)


;; 在新闻组中回复个人时予以警告
(setq gnus-confirm-mail-reply-to-news t)

;; 发送时自动填冲的字段
(setq gnus-posting-styles
  '((".*"
     (name "JackPhil")  ;; 默认
     (address "foo4@gmail.com")
     (signature-file "~/.emacs.d/gnus/signature/default")
     )
    ("mail.python-chinese"
     (name "JackPhil")
     (address "foo4@gmail.com")
     (signature-file "~/.emacs.d/gnus/signature/trueknowlege"))
   ))


;; 中文支持,chinese-iso-8bit
(setq gnus-default-charset 'cn-gb-2312
      gnus-group-name-charset-group-alist '((".*" . cn-gb-2312))
      gnus-summary-show-article-charset-alist '((1 . cn-gb-2312)
        					(2 . big5)
						(3 . utf-8)
						(4 . gbk)
       					       )
      gnus-newsgroup-ignored-charsets '(unknown-8bit x-unknown iso-8859-1)
)

;; 地址簿
(setq bbdb-file "~/.emacs.d/gnus/bbdb")
(require 'bbdb)
(bbdb-initialize)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-message)
(add-hook 'message-setup-hook 'bbdb-define-all-aliases)


