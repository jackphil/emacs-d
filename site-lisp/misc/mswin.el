;#设置buffer的默认目录，MS-Windows下尤其需要，因为它的默认值是emacs程序所在目录
(setq default-directory "~/"
	  ange-ftp-tmp-name-template "~/.emacs.d/tmp")

;#文件编码
;;#如有可能就使用utf-8
(set-language-environment 'utf-8)
;;#设置新开buffer和及保存时的默认编码
;;(set-buffer-file-coding-system 'utf-8)
;;#Windows下正确显示和保存中文文件名
(set-file-name-coding-system 'chinese-gbk)
;;#可以设置多个，注意后设置的使用时优先
(prefer-coding-system 'chinese-gbk)
(prefer-coding-system 'utf-8)

;#字体，透明度，窗口位置大小
(setq default-frame-alist
      (append ;;"文泉驿等宽正黑-18" or "文泉驿等宽正黑:size=18"
       '((font . "文泉驿等宽正黑") 
	 ;;透明度
	 (alpha . (85 50))
	 ;;左上角坐标
	 (top . 0) (left . 0)
	 ;;窗口大小：行数和列数
	 (height . 39) (width . 80))))

;#其它可选配置
;;#默认字体：等宽，中英文1:2，字体小了显示粗糙
;;(set-default-font "文泉驿等宽正黑:size=18")

;;#默认窗口大小
;;(w32-send-sys-command 61488) ;;最大化
;;(set-frame-size (selected-frame) 80 39) ;;也可以指定宽和高
