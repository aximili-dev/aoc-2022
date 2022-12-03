(in-package #:aoc-2022)

(defun day-02-1 (input-file)
  (with-open-file (input input-file)
    (let ((score 0))
      (loop for line = (read-line input nil)
	    while line do (incf score (get-line-score line)))
      (format t "Score: ~a~%" score))))

(defun get-line-score (line)
  (let ((p1 (car (parse-line line)))
	(p2 (cdr (parse-line line))))
    (+ (get-hand-score p2)
       (get-victory-score p1 p2))))

(defun get-hand-score (p2)
  (cond
    ((eq p2 #\X) 1)
    ((eq p2 #\Y) 2)
    ((eq p2 #\Z) 3)))

(defun get-victory-score (p1 p2)
  (cond
    ((result #\A #\X) 3)
    ((result #\B #\Y) 3)
    ((result #\C #\Z) 3)

    ((result #\A #\Y) 6)
    ((result #\B #\Z) 6)
    ((result #\C #\X) 6)

    ((result #\A #\Z) 0)
    ((result #\B #\X) 0)
    ((result #\C #\Y) 0)))

(defmacro result (p1 p2)
  `(and (eq p1 ,p1) (eq p2 ,p2)))
  

(defun parse-line (line)
  (with-input-from-string (in line)
    (let ((p1 nil) (p2 nil))
      (setf p1 (read-char in))
      (read-char in)
      (setf p2 (read-char in))
      (cons p1 p2))))

(register-solution 2 1 day-02-1)
