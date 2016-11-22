(setq c-mode-hook
      (function (lambda ()
		  (setq indent-tabs-mode nil)
		  (setq c-basic-offset 4))))

(setq c++-mode-hook
      (function (lambda ()
		  (setq indent-tabs-mode nil)
		  (setq c-basic-offset 4))))

(c-set-offset 'substatement-open 0)

(provide 'my-c_cpp)
