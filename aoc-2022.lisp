;;;; aoc-2022.lisp

(in-package #:aoc-2022)

(defparameter *solutions* '())

(defun run-solution (day puzzle input)
  (let ((solution (cdr (assoc `(,day . ,puzzle) *solutions*
			      :test #'equal))))
    (funcall solution input)))

(defmacro register-solution (day puzzle fun-name)
  `(push (cons (cons ,day ,puzzle) (function ,fun-name)) *solutions*)) 

(defun insert-sorted (item list)
  (if (or (null list) (> item (first list)))
      (push item list)
      (cons (first list)
	    (insert-sorted item (rest list)))))
