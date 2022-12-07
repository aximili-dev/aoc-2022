;; day-06.lisp

(in-package #:aoc-2022)

(defsolution (input-file) 6 1
  (with-opn-file (in input-file)
    (let ((str (read-line in))
	  (buffer '()))
      (loop for i from 0
	    for c across str
	    
	    do (progn
		 (push c buffer)
		 (when (check-buffer buffer)
		   (format "N: ~a~%")
		   (return))
		 (setf buffer (butlast buffer)))))))

(defun check-buffer (buffer))
