;;;; day-01.lisp

(in-package #:aoc-2022)

(defsolution (input-file) 1 1
  (let ((current-counter 0)
	(current-max 0))
    (for-input-lines (line input-file)
      (if (string= line "")
	  (progn
	    (setf current-max (max current-counter current-max))
	    (setf current-counter 0))
	  (incf current-counter (parse-integer line))))
    (format t "Max calories: ~a~%" current-max)))

(defsolution (input-file) 1 2
  (let ((current-counter 0)
	(top-3 '()))
    (for-input-lines (line input-file)
      (if (or (string= line "") (eq line nil))
	  (progn
	    (setf top-3 (insert-sorted current-counter top-3))
	    (setf current-counter 0))
	  (incf current-counter (parse-integer line))))
    (format t "Sum of top 3 max calories: ~a~%"
	    (+ (first top-3)
	       (second top-3)
	       (third top-3)))))
