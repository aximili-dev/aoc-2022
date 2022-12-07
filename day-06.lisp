;; day-06.lisp

(in-package #:aoc-2022)

(defsolution (input-file) 6 1
  (with-open-file (in input-file)
    (let ((str (read-line in))
	  (buffer '()))
      (loop for i from 0
	    for c across str
	    
	    do (progn
		 (push c buffer)
		 (when (check-buffer buffer)
		   (format t "N: ~a~%" (1+ i))
		   (return))

		 (if (>= (length buffer) 4)
		     (setf buffer (butlast buffer))))))))

(defsolution (input-file) 6 2
  (with-open-file (in input-file)
    (let ((str (read-line in))
	  (buffer '()))
      (loop for i from 0
	    for c across str
	    
	    do (progn
		 (push c buffer)
		 (when (check-buffer buffer 14)
		   (format t "N: ~a~%" (1+ i))
		   (return))

		 (if (>= (length buffer) 14)
		     (setf buffer (butlast buffer))))))))

(defun check-buffer (buffer &optional (len 4))
  (unless (< (length buffer) len)
    (let ((tmp '())
	  (ret t))
      (dolist (c buffer)
	(if (assoc c tmp)
	    (setf ret nil)
	    (push (cons c nil) tmp)))

      ret)))
