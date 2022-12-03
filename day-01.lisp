;;;; day-01.lisp

(in-package #:aoc-2022)

(defun day-01-1 (input-file)
  (with-open-file (input input-file)
    (let ((current-counter 0)
	  (current-max 0))
      (loop for line = (read-line input nil)
	    while line do (if (string= line "")
			      (progn
				(setf current-max (max current-counter current-max))
				(setf current-counter 0))
			      (incf current-counter (parse-integer line))))
      (format t "Max calories: ~a~%" current-max))))

(register-solution 1 1 day-01-1)
