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

(defun day-01-2 (input-file)
  (with-open-file (input input-file)
    (let ((current-counter 0)
	  (top-3 '()))
      (loop for line = (read-line input nil)
	    do (if (or (string= line "") (eq line nil))
		   (progn
		     (setf top-3 (insert-sorted current-counter top-3))
		     (setf current-counter 0))
		   (incf current-counter (parse-integer line)))
	    while line)
      (format t "Sum of top 3 max calories: ~a~%"
	      (+ (first top-3)
		 (second top-3)
		 (third top-3))))))

(register-solution 1 2 day-01-2)
