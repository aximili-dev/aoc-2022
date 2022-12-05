; day-03.lisp

(in-package #:aoc-2022)

(defsolution (input-file) 3 1
  (let ((priority-sum 0))
    (for-input-lines (line input-file)
      (if (and line (not (string= line "")))
	  (multiple-value-bind (h1 h2) (halve-line line)
	    (let* ((union (logand (items-bitset h1)
				  (items-bitset h2)))
		   (priority (round (log union 2))))
	      ;;;(format t "~a ^ ~a: ~64,'0,' ,8b~%" h1 h2 union)
	      (format t "~b~%" union)
	      (incf priority-sum priority)))))
    (format t "Priority sum: ~a~%" priority-sum)))
      
(defun halve-line (line)
  (let* ((len (length line))
	 (half (/ len 2)))
    (values-list (list (subseq line 0 half)
		       (subseq line half len)))))

(defun items-bitset (items)
  (let ((set 0))
    (loop for char across items
	  while char do (let ((priority (item-priority char)))
			  (setf (ldb (byte 1 priority) set) 1)))
    set))

(defun item-priority (char)
  (let ((code (char-code char))
	(up-a (char-code #\A))
	(lo-a (char-code #\a)))
    (if (upper-case-p char)
	(+ 27 (- code up-a))
	(+ 1  (- code lo-a)))))
