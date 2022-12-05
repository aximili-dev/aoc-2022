;; day-04.lisp

(in-package #:aoc-2022)

(defsolution (input-file) 4 1
  (let ((overlaps 0))
    (for-input-lines (line input-file)
      (multiple-value-bind (r1 r2) (parse-ranges line)
	(if (fully-overlap r1 r2)
	    (incf overlaps))))
    (format t "Number of overlaps: ~d~%" overlaps)))

(defsolution (input-file) 4 2
  (let ((overlaps 0))
    (for-input-lines (line input-file)
      (multiple-value-bind (r1 r2) (parse-ranges line)
	(unless (zerop (overlap r1 r2))
	  (incf overlaps))))
    (format t "Number of overlaps: ~d~%" overlaps)))

(defun parse-ranges (line)
  (let ((regex (format nil "~a~:*-~a~:*,~a~:*-~a" "([\\d.]+)")))
    (cl-ppcre:register-groups-bind (s1 e1 s2 e2) (regex line)
      (values (cons (parse-integer s1) (parse-integer e1))
	      (cons (parse-integer s2) (parse-integer e2))))))

(defun range-bitset (start end)
  (let ((set 0))
    (loop for i from start to end
	  do (setf (ldb (byte 1 i) set) 1))
    set))

(defun overlap (r1 r2)
  (let* ((s1 (car r1))
	 (e1 (cdr r1))
	 (s2 (car r2))
	 (e2 (cdr r2))
	 (r1 (range-bitset s1 e1))
	 (r2 (range-bitset s2 e2)))
    (logand r1 r2)))

(defun fully-overlap (r1 r2)
  (let* ((s1 (car r1))
	 (e1 (cdr r1))
	 (s2 (car r2))
	 (e2 (cdr r2))
	 (r1 (range-bitset s1 e1))
	 (r2 (range-bitset s2 e2)))
  (or (eq 0 (logandc1 r1 r2))
      (eq 0 (logandc1 r2 r1)))))

(defun n-overlaps (r1 r2)
  (let* ((s1 (car r1))
	 (e1 (cdr r1))
	 (s2 (car r2))
	 (e2 (cdr r2))
	 (r1 (range-bitset s1 e1))
	 (r2 (range-bitset s2 e2))
	 (acc 0))
    (iterate-bits-of (logand r1 r2)
		     #'(lambda (x)
			 (if (not (zerop x))
			     (incf acc))))
    acc))
    
  
