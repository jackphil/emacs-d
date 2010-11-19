;#字体，窗口位置，窗口大小
(setq default-frame-alist 
      (append '(;; "文泉驿等宽正黑-18" or "文泉驿等宽正黑:size=18"
		(font . "文泉驿等宽正黑")
		;; 透明度设置，即使不起作用也无害
		(alpha . (85 50))
		;; 左上角坐标
		(top . 0) (left . 0)
		;; 窗口大小：行数和列数
		(height . 34) (width . 80))))

;#在信息栏显示时间
;;在我的Vista上会导致崩溃，所以放在这里
;;(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)

;#其它可选配置
;;#默认字体：等宽，中英文1:2
(set-default-font "雅黑MONO:size=18")