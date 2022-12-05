; day-03.lisp

(in-package #:aoc-2022)

(defsolution (input-file) 3 1
  (let ((priority-sum 0))
    (for-input-lines (line input-file)
      (if (and line (not (string= line "")))
	  (multiple-value-bind (h1 h2) (halve-line line)
	    (incf priority-sum (shared-item-priority h1 h2)))))
    (format t "Priority sum: ~a~%" priority-sum)))

(defsolution (input-file) 3 2
  (let ((priority-sum 0)
	(lines '()))
    (for-input-lines (line input-file)
      (if (and line (not (string= line "")))
	  (push line lines))

      (when (eq (length lines) 3)
	(incf priority-sum (apply #'shared-item-priority lines))
	(setf lines '())))

    (format t "Priority sum: ~a~%" priority-sum)))
	
      
(defun halve-line (line)
  (let* ((len (length line))
	 (half (/ len 2)))
    (values-list (list (subseq line 0 half)
		       (subseq line half len)))))

(defun items-bitset (items)
  (string-bitset items #'item-priority))

(defun item-priority (char)
  (let ((code (char-code char))
	(up-a (char-code #\A))
	(lo-a (char-code #\a)))
    (if (upper-case-p char)
	(+ 27 (- code up-a))
	(+ 1  (- code lo-a)))))

(defun shared-item-priority (&rest item-lists)
  (let ((union (apply #'logand
		      (mapcar #'items-bitset item-lists))))
    (round (log union 2))))
