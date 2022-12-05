;;;; aoc-2022.lisp

(in-package #:aoc-2022)

(defparameter *solutions* '())

(defun run-solution (day puzzle input)
  (let ((solution (cdr (assoc `(,day . ,puzzle) *solutions*
			      :test #'equal))))
    (funcall solution input)))

(defmacro register-solution (day puzzle fun-name)
  `(push (cons (cons ,day ,puzzle) (function ,fun-name)) *solutions*)) 

(defmacro defsolution (fun-args day puzzle &body body)
  (let ((fun-name (gensym (format nil "day-~2,'0d-~d-" day puzzle))))
    `(progn
       (defun ,fun-name (,@fun-args)
	 ,@body)

       (register-solution ,day ,puzzle ,fun-name))))
  
(defun insert-sorted (item list)
  (if (or (null list) (> item (first list)))
      (push item list)
      (cons (first list)
	    (insert-sorted item (rest list)))))

(defmacro for-input-lines ((line input-file) &body body)
  `(with-open-file (input ,input-file)
     (loop for ,line = (read-line input nil)
	   do (progn ,@body)
	   while ,line)))

(defun string-bitset (str bit-fun)
  (let ((set 0))
    (loop for char across str
	  while char do
	    (let ((bit-pos (funcall bit-fun char)))
	      (setf (ldb (byte 1 bit-pos) set) 1)))
    set))
