;; 设置buffer的默认目录，MS-Windows下尤其需要，因为它的默认值是emacs程序所在目录
(setq default-directory "C:/Documents and Settings/foo/My Documents/"
	  ange-ftp-tmp-name-template "C:/docume~1/alluse~1/docume~1/home/.emacs.d/tmp")

;; 文件编码
;; 如有可能就使用utf-8
(set-language-environment 'utf-8)
;; 设置新开buffer和及保存时的默认编码
;;(set-buffer-file-coding-system 'utf-8)
;; Windows下正确显示和保存中文文件名
(set-file-name-coding-system 'chinese-gbk)
;; 可以设置多个，注意后设置的使用时优先
(prefer-coding-system 'chinese-gbk)
(prefer-coding-system 'utf-8)

;; 字体
(create-fontset-from-fontset-spec
"-outline-Courier New-normal-r-normal-normal-13-97-96-96-c-*-fontset-chinese")
(set-fontset-font
"fontset-default" nil
"-outline-新宋体-normal-r-normal-normal-14-*-96-96-c-*-iso10646-1" nil 'prepend)
(set-fontset-font
"fontset-chinese" 'kana
"-outline-新宋体-normal-r-normal-normal-14-*-96-96-c-*-iso10646-1" nil 'prepend)
(set-fontset-font
"fontset-chinese" 'han
"-outline-新宋体-normal-r-normal-normal-14-*-96-96-c-*-iso10646-1" nil 'prepend)
(set-fontset-font
"fontset-chinese" 'cjk-misc
"-outline-新宋体-normal-r-normal-normal-14-*-96-96-c-*-iso10646-1" nil 'prepend)
(set-fontset-font
"fontset-chinese" 'symbol
"-outline-新宋体-normal-r-normal-normal-14-*-96-96-c-*-iso10646-1" nil 'prepend)
(set-default-font "fontset-chinese")