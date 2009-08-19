;; 在我的Vista上会导致崩溃，所以放在这里
;; 在信息栏显示时间
;;(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)

;; Windows上乱码
;; http://learn.tsinghua.edu.cn:8080/2005211356/emacs/wikisource/MyElisp.muse:
;; emacs 没有提供多语言的方案。但是用它提供的接口还是可以用 elisp 实现菜
;; 单的汉化。不过用起来还是有点问题，比如 Windows 下菜单编码不确定，导致乱
;; 码（原因没有找到）；M-`(tmm-menubar) 不能用等等。不过一般都不用菜单，
;; 为了好看我还是一直用着。
(require 'english-menu)
(require 'chinese-menu)
(require 'mule-menu)

;; 默认字体：等宽，中英文1:2
(set-default-font "雅黑MONO:size=18")